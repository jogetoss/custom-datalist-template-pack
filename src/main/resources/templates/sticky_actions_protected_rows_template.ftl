<div class="table-responsive">
    <table class="table table-hover">
        <thead>
            <tr>
                {{selector}}
                    <th class="sapr-select-all-header" style="width: 40px;">{{body}}</th>
                {{selector}}
                {{columns data-cbuilder-sort-horizontal data-cbuilder-prepend data-cbuilder-style='[{"class": "td", "label": "Body"}, {"prefix": "header", "class": "th", "label": "Header"}]'}}
                    {{column}}
                        <th data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@">{{label||Sample Label}}</th>
                    {{column}}
                {{columns}}
                <th class="sapr-actions-column" style="width: 150px;">Actions</th>
            </tr>
        </thead>
        <tbody>
            {{rows data-cbuilder-highlight="@@datalist.simpleListTemplate.list@@" data-cbuilder-style="[{'prefix' : 'list', 'class' : '.list-group-item', 'label' : '@@datalist.simpleListTemplate.list@@'}]"}}
                <tr class="data-row">
                    {{selector}}
                        <td>{{body}}</td>
                    {{selector}}
                    {{columns data-cbuilder-sync}}
                        {{column}}
                            <td data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@">{{body||Sample Value}}</td>
                        {{column}}
                    {{columns}}
                    <td class="sapr-actions-column">
                        {{rowActions}}
                            <div class="px-md-3 rowActionsContainer">
                                <div class="rowActions" data-cbuilder-sort-horizontal>{{rowAction}}</div>
                            </div>
                        {{rowActions}}
                    </td>
                </tr>
            {{rows}}
        </tbody>
    </table>
</div>

<div class="datalist-footer" style="display:flex; justify-content:space-between; align-items:center; gap:12px; flex-wrap:wrap; padding: 6px 0;">
    <div class="datalist-paging">
        {{paging}}
    </div>
    <div class="datalist-export" style="margin-left:auto;">
        {{export}}
    </div>
</div>

<div id="datalistInfo_{{list.id}}" class="datalist-result-info" style="text-align:right; padding: 2px 0 6px; font-size: 12px; color: #6c757d;"></div>

<script>
(function () {
    var listEl = document.getElementById("dataList_{{list.id}}");
    if (!listEl) return;

    var infoEl = document.getElementById("datalistInfo_{{list.id}}");
    if (!infoEl) return;

    function getParam(name) {
        try {
            var url = new URL(window.location.href);
            return url.searchParams.get(name);
        } catch (e) {
            return null;
        }
    }

    function toInt(val, fallback) {
        var n = parseInt(val, 10);
        return isNaN(n) ? fallback : n;
    }

    function getAllParams() {
        try {
            return new URL(window.location.href).searchParams;
        } catch (e) {
            return null;
        }
    }

    function pickDisplayTagParam(suffix) {
        // Joget DataList often uses DisplayTag params like d-12345-p (page) and d-12345-s (page size)
        var sp = getAllParams();
        if (!sp) return null;
        var foundKey = null;
        sp.forEach(function (_v, k) {
            if (k && k.length > suffix.length && k.slice(-suffix.length) === suffix) {
                foundKey = k;
            }
        });
        return foundKey;
    }

    // 1) Count visible data rows on this page
    var table = listEl.querySelector(".table");
    var rowsOnPage = 0;
    if (table) {
        var bodyRows = table.querySelectorAll("tbody tr");
        for (var i = 0; i < bodyRows.length; i++) {
            var tr = bodyRows[i];
            if (tr.classList && tr.classList.contains("expandable-content-row")) continue;
            rowsOnPage++;
        }
    }

    // 2) Determine current page number
    var page = null;
    // DisplayTag param (preferred)
    var dtPageKey = pickDisplayTagParam("-p");
    if (dtPageKey) page = toInt(getParam(dtPageKey), null);
    // Common fallbacks
    if (page === null) page = toInt(getParam("page"), null);
    if (page === null) page = toInt(getParam("p"), null);
    if (page === null) {
        // Read active page from pagination UI
        var activePage =
            listEl.querySelector(".pagination li.active") ||
            listEl.querySelector(".pagination .active") ||
            listEl.querySelector(".pagelinks .current");
        if (activePage) page = toInt(activePage.textContent, 1);
    }
    if (page === null) page = 1;

    // 3) Determine page size
    var pageSize = null;
    // DisplayTag param (preferred)
    var dtSizeKey = pickDisplayTagParam("-s");
    if (dtSizeKey) pageSize = toInt(getParam(dtSizeKey), null);
    // Common fallbacks
    if (pageSize === null) pageSize = toInt(getParam("pageSize"), null);
    if (pageSize === null) pageSize = toInt(getParam("rows"), null);
    if (pageSize === null) {
        var psInput = listEl.querySelector("select[name='pageSize'], input[name='pageSize'], select[name='rows'], input[name='rows']");
        if (psInput) pageSize = toInt(psInput.value, null);
    }
    if (pageSize === null || pageSize <= 0) pageSize = rowsOnPage || 0;

    // 4) Try to detect total items from any existing pager/banner text
    var total = null;
    var patterns = [
        /(\d+)\s+(?:items?|records?)\s+found/i,
        /(\d+)\s+item\(s\)\s+found/i,
        /found\s+(\d+)\s+(?:items?|records?)/i
    ];

    function extractTotalFromText(text) {
        if (!text) return null;
        var t = String(text).replace(/\s+/g, " ").trim();
        for (var p = 0; p < patterns.length; p++) {
            var m = t.match(patterns[p]);
            if (m && m[1]) return toInt(m[1], null);
        }
        return null;
    }

    // 4a) Banner areas near/around the list
    if (total === null) {
        // Sometimes the "items found" banner is outside the list element
        var candidates = document.querySelectorAll(".pagebanner, .dataListPageBanner, .datalist-paging, .datalist-footer, .dataList");
        for (var c = 0; c < candidates.length; c++) {
            total = extractTotalFromText(candidates[c].textContent);
            if (total !== null) break;
        }
    }

    var start = 0, end = 0;
    if (rowsOnPage > 0 && pageSize > 0) {
        start = ((page - 1) * pageSize) + 1;
        end = start + rowsOnPage - 1;
    }

    function renderInfo(foundTotal) {
        if (foundTotal !== null && foundTotal !== undefined) {
            infoEl.textContent = foundTotal + " items found, displaying " + start + " to " + Math.min(end, foundTotal) + ".";
        } else if (rowsOnPage > 0) {
            infoEl.textContent = "Displaying " + start + " to " + end + ".";
        } else {
            infoEl.textContent = "";
        }
    }

    // Cache key to keep totals consistent across navigation/reload
    var cacheKey = "joget:datalistTotal:{{list.id}}:" + window.location.pathname;
    var cachedTotal = toInt((window.sessionStorage && sessionStorage.getItem(cacheKey)) || "", null);

    // If we have a cached total, prefer it immediately
    if (cachedTotal !== null) {
        total = cachedTotal;
    }

    // Render immediately (may not have total yet)
    renderInfo(total);

    // If total isn't present in DOM, derive it by fetching the last page once.
    // This keeps it accurate without needing server-side template variables.
    function computeLastPage() {
        var lastPage = null;

        // A) Try visible page numbers first
        var pagination = listEl.querySelector(".pagination");
        if (pagination) {
            var pageLinks = pagination.querySelectorAll("a, span, li");
            for (var i = 0; i < pageLinks.length; i++) {
                var n = toInt((pageLinks[i].textContent || "").trim(), null);
                if (n !== null) {
                    if (lastPage === null || n > lastPage) lastPage = n;
                }
            }
        }

        // B) If theme uses icons, read page numbers from href query params
        var pageParamKey = dtPageKey || "page";
        var links = listEl.querySelectorAll("a[href]");
        for (var j = 0; j < links.length; j++) {
            var href = links[j].getAttribute("href") || "";
            if (!href) continue;
            try {
                var u = new URL(href, window.location.href);
                var pn = toInt(u.searchParams.get(pageParamKey), null);
                if (pn !== null) {
                    if (lastPage === null || pn > lastPage) lastPage = pn;
                }
                // Also check for any displaytag-style page param if we haven't locked onto one
                if (!dtPageKey) {
                    u.searchParams.forEach(function (v, k) {
                        if (k && k.slice(-2) === "-p") {
                            var pn2 = toInt(v, null);
                            if (pn2 !== null) {
                                dtPageKey = k;
                                if (lastPage === null || pn2 > lastPage) lastPage = pn2;
                            }
                        }
                    });
                }
            } catch (e) {}
        }

        // C) Some pagers store current/last in data attributes
        var dataLast = listEl.querySelector("[data-last-page], [data-total-pages]");
        if (dataLast) {
            var dl = toInt(dataLast.getAttribute("data-last-page") || dataLast.getAttribute("data-total-pages"), null);
            if (dl !== null) {
                if (lastPage === null || dl > lastPage) lastPage = dl;
            }
        }

        return lastPage;
    }

    function shouldRecomputeTotal(foundTotal, lastPage) {
        // On first load some pages expose a misleading "total" (often equals rowsOnPage).
        // If there are multiple pages, prefer recomputation unless we have a larger, credible total.
        if (!lastPage || lastPage <= 1) return foundTotal === null;
        if (foundTotal === null) return true;
        // Suspicious if total doesn't exceed the current end index while we know there are more pages.
        if (foundTotal <= end) return true;
        return false;
    }

    function fetchAndComputeTotal(lastPage) {
        try {
            var url = new URL(window.location.href);
            if (dtPageKey) url.searchParams.set(dtPageKey, String(lastPage));
            else url.searchParams.set("page", String(lastPage));
            if (dtSizeKey) url.searchParams.set(dtSizeKey, String(pageSize));

            fetch(url.toString(), { credentials: "same-origin" })
                .then(function (r) { return r.text(); })
                .then(function (html) {
                    var parser = new DOMParser();
                    var doc = parser.parseFromString(html, "text/html");
                    var remoteList = doc.getElementById("dataList_{{list.id}}");
                    var remoteTable = remoteList ? remoteList.querySelector(".table") : null;
                    var lastRows = 0;
                    if (remoteTable) {
                        var trs = remoteTable.querySelectorAll("tbody tr");
                        for (var x = 0; x < trs.length; x++) {
                            var tr = trs[x];
                            if (tr.classList && tr.classList.contains("expandable-content-row")) continue;
                            lastRows++;
                        }
                    }
                    if (lastRows > 0) {
                        var computedTotal = ((lastPage - 1) * pageSize) + lastRows;
                        if (window.sessionStorage) sessionStorage.setItem(cacheKey, String(computedTotal));
                        renderInfo(computedTotal);
                    }
                })
                .catch(function () { /* ignore */ });
        } catch (e) { /* ignore */ }
    }

    function maybeRecomputeTotal() {
        if (!(rowsOnPage > 0 && pageSize > 0)) return;
        var lastPage = computeLastPage();
        if (!lastPage) return;
        if (shouldRecomputeTotal(total, lastPage)) {
            fetchAndComputeTotal(lastPage);
        }
    }

    // Attempt immediately, then retry shortly (pagination sometimes renders after initial HTML)
    if (rowsOnPage > 0 && pageSize > 0) {
        maybeRecomputeTotal();
        setTimeout(function () {
            maybeRecomputeTotal();
        }, 300);
    }

    // Backward compatibility: keep existing behavior if something above fails
    if (false && total === null && rowsOnPage > 0 && pageSize > 0) {
        try {
            var pagination = listEl.querySelector(".pagination");
            var lastPage = null;
            if (pagination) {
                var pageLinks = pagination.querySelectorAll("a, span");
                for (var i = 0; i < pageLinks.length; i++) {
                    var n = toInt((pageLinks[i].textContent || "").trim(), null);
                    if (n !== null) {
                        if (lastPage === null || n > lastPage) lastPage = n;
                    }
                }
            }

            // Fallback: infer last page from any link href containing the page param key
            if (lastPage === null) {
                var hrefLinks = listEl.querySelectorAll("a[href]");
                for (var j = 0; j < hrefLinks.length; j++) {
                    var href = hrefLinks[j].getAttribute("href") || "";
                    if (!href) continue;
                    try {
                        var u = new URL(href, window.location.href);
                        var k = dtPageKey || "page";
                        var n2 = toInt(u.searchParams.get(k), null);
                        if (n2 !== null) {
                            if (lastPage === null || n2 > lastPage) lastPage = n2;
                        }
                    } catch (e) {}
                }
            }

            if (lastPage !== null && lastPage > 0) {
                // Only fetch if we're not already on the last page and total isn't available.
                var url = new URL(window.location.href);
                if (dtPageKey) url.searchParams.set(dtPageKey, String(lastPage));
                else url.searchParams.set("page", String(lastPage));
                if (dtSizeKey) url.searchParams.set(dtSizeKey, String(pageSize));

                fetch(url.toString(), { credentials: "same-origin" })
                    .then(function (r) { return r.text(); })
                    .then(function (html) {
                        var parser = new DOMParser();
                        var doc = parser.parseFromString(html, "text/html");
                        var remoteList = doc.getElementById("dataList_{{list.id}}");
                        var remoteTable = remoteList ? remoteList.querySelector(".table") : null;
                        var lastRows = 0;
                        if (remoteTable) {
                            var trs = remoteTable.querySelectorAll("tbody tr");
                            for (var x = 0; x < trs.length; x++) {
                                var tr = trs[x];
                                if (tr.classList && tr.classList.contains("expandable-content-row")) continue;
                                lastRows++;
                            }
                        }
                        if (lastRows > 0) {
                            var computedTotal = ((lastPage - 1) * pageSize) + lastRows;
                            renderInfo(computedTotal);
                        }
                    })
                    .catch(function () { /* ignore */ });
            }
        } catch (e) {
            // ignore
        }
    }
})();
</script>

<style>
/* Sticky Actions column - stays visible when scrolling horizontally */
#dataList_{{list.id}} .sapr-actions-column {
    position: sticky;
    right: 0;
    z-index: 2;
    background: #fff;
    box-shadow: -4px 0 8px rgba(0, 0, 0, 0.06);
}
#dataList_{{list.id}} .table thead .sapr-actions-column {
    background: #f8f9fa;
}
#dataList_{{list.id}} .table tbody tr:hover .sapr-actions-column {
    background: #f1f3f5;
}

/* RTL: sticky on left */
body.rtl #dataList_{{list.id}} .sapr-actions-column {
    right: auto;
    left: 0;
    box-shadow: 4px 0 8px rgba(0, 0, 0, 0.06);
}

/* RTL Support */
body.rtl #dataList_{{list.id}} .table-wrapper .flex-fill {
    display: flex;
    flex-direction: column;
    text-align: right;
}
body.rtl .table > tbody > tr > td:first-child {
    text-align: right !important;
}

/* Hide separator in last visible column */
#dataList_{{list.id}} .d-flex.flex-column.flex-md-row.flex-wrap
  > .ph_columns:not(.column-hidden):not(:has(~ .ph_columns:not(.column-hidden))) .mx-1 {
  display: none !important;
}

/* Row Actions Spacing */
.rowActions.d-flex > a {
    margin-right: 8px !important;
    margin-bottom: 4px !important;
}
.rowActions.d-flex > a:last-child {
    margin-right: 0 !important;
}
</style>

<script>
(function() {
    var listEl = document.getElementById("dataList_{{list.id}}");
    if (!listEl) return;

    var table = listEl.querySelector(".table");
    if (!table) return;

    var theadCheckbox = table.querySelector("thead .sapr-select-all-header input[type='checkbox']");
    var rowCheckboxes = function() { return table.querySelectorAll("tbody tr td:first-child input[type='checkbox']"); };

    // Protected Rows: conditions from repeater (element.properties.protectedRowsConditionGrid)
    var conditions = [];
    <#assign conditionGridRaw = element.properties.protectedRowsConditionGrid!"" />
    <#if conditionGridRaw?is_sequence>
        <#list conditionGridRaw as condition>
    conditions.push({ columnId: '${(condition.gridColumnId!"")?js_string}', value: '${(condition.gridValue!"")?js_string}' });
        </#list>
    <#elseif conditionGridRaw?is_string && conditionGridRaw != "" && conditionGridRaw != "[]">
    try {
        var parsed = JSON.parse('${conditionGridRaw?js_string}');
        if (Array.isArray(parsed)) {
            conditions = parsed.map(function(cond) {
                return { columnId: (cond.gridColumnId || cond.columnId || '').trim(), value: (cond.gridValue || cond.value || '').trim() };
            });
        }
    } catch (e) {}
    </#if>

    // Disable selection for rows that match any condition (Protected Rows)
    var rows = table.querySelectorAll("tbody tr");
    for (var r = 0; r < rows.length; r++) {
        var row = rows[r];
        var matched = false;
        for (var i = 0; i < conditions.length; i++) {
            var columnId = conditions[i].columnId;
            var matchValue = conditions[i].value;
            if (!columnId || matchValue === undefined) continue;
            var cells = row.querySelectorAll("td");
            var cell = null;
            for (var c = 0; c < cells.length; c++) {
                var td = cells[c];
                if (td.classList.contains("sapr-actions-column")) continue;
                var tid = (td.getAttribute("data-column-id") || "").trim();
                var cls = (td.className || "") + " ";
                if (tid === columnId || cls.indexOf("column_" + columnId + " ") !== -1 || cls.indexOf("column_" + columnId) === 0 || cls.indexOf(" ph_column_" + columnId) !== -1) {
                    cell = td;
                    break;
                }
            }
            if (cell) {
                var cellText = (cell.textContent || cell.innerText || "").trim();
                if (cellText === matchValue) {
                    matched = true;
                    break;
                }
            }
        }
        if (matched) {
            var cb = row.querySelector("td:first-child input[type='checkbox']");
            if (cb) {
                cb.disabled = true;
                cb.setAttribute("title", "Selection disabled for this row");
                // Hide the selection checkbox entirely for protected rows
                cb.style.display = "none";
            }
        }
    }

    function syncHeaderFromRows() {
        if (!theadCheckbox) return;
        var checkboxes = rowCheckboxes();
        var checked = 0, enabled = 0;
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].disabled) continue;
            enabled++;
            if (checkboxes[i].checked) checked++;
        }
        theadCheckbox.checked = (enabled > 0 && checked === enabled);
        theadCheckbox.indeterminate = (checked > 0 && checked < enabled);
    }

    function syncRowsFromHeader() {
        var checkboxes = rowCheckboxes();
        for (var i = 0; i < checkboxes.length; i++) {
            if (!checkboxes[i].disabled) {
                checkboxes[i].checked = theadCheckbox.checked;
            }
        }
    }

    if (theadCheckbox) {
        theadCheckbox.addEventListener("change", function() {
            syncRowsFromHeader();
        });
    }

    table.addEventListener("change", function(e) {
        if (e.target && e.target.type === "checkbox" && e.target.closest("tbody tr td:first-child")) {
            syncHeaderFromRows();
        }
    });

    syncHeaderFromRows();
})();
</script>
