<#assign _dl = element.datalist />
<#assign _sortParam = _dl.getDataListEncodedParamName("s") />
<#assign _orderParam = _dl.getDataListEncodedParamName("o") />
<#assign _pageParam = _dl.getDataListEncodedParamName("p") />
<#assign _curSort = (_dl.getDataListParamString("s"))!"" />
<#assign _curOrder = (_dl.getDataListParamString("o"))!"" />
<#assign _sortableIds = element.sortableColumnIds />
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
    var infoEl = document.getElementById("datalistInfo_{{list.id}}");
    if (!listEl || !infoEl) return;

    var url = new URL(window.location.href);
    var sp = url.searchParams;

    var table = listEl.querySelector(".table");
    var rows = table ? table.querySelectorAll("tbody tr") : [];
    var rowsOnPage = 0;
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].classList && rows[i].classList.contains("expandable-content-row")) continue;
        rowsOnPage++;
    }
    if (!rowsOnPage) return;

    function int(v, d) { v = parseInt(v, 10); return isNaN(v) ? d : v; }
    function findKey(suffix) {
        var k = null;
        sp.forEach(function (_v, key) { if (key && key.slice(-suffix.length) === suffix) k = key; });
        return k;
    }
    var pKey = findKey("-p") || "page";
    var sKey = findKey("-s") || "pageSize";
    var page = int(sp.get(pKey) || sp.get("p"), 1);
    var pageSize = int(sp.get(sKey) || sp.get("rows"), rowsOnPage);

    var start = ((page - 1) * pageSize) + 1;
    var end = start + rowsOnPage - 1;

    function show(total) {
        infoEl.textContent = total
            ? (total + " items found, displaying " + start + " to " + Math.min(end, total) + ".")
            : ("Displaying " + start + " to " + end + ".");
    }

    var cacheKey = "joget:datalistTotal:{{list.id}}:" + window.location.pathname;
    var cached = null;
    try { cached = int(sessionStorage.getItem(cacheKey), null); } catch (e) {}
    if (cached) return show(cached);

    show(null);

    // Compute total once by requesting last page and counting its rows
    var lastPage = null;
    var links = listEl.querySelectorAll(".pagination a[href], a[href]");
    for (var j = 0; j < links.length; j++) {
        try {
            var u = new URL(links[j].getAttribute("href"), window.location.href);
            var n = int(u.searchParams.get(pKey), null);
            if (n && (!lastPage || n > lastPage)) lastPage = n;
        } catch (e) {}
    }
    if (!lastPage || lastPage <= 1) return;

    var lastUrl = new URL(window.location.href);
    lastUrl.searchParams.set(pKey, String(lastPage));
    if (findKey("-s")) lastUrl.searchParams.set(sKey, String(pageSize));

    fetch(lastUrl.toString(), { credentials: "same-origin" })
        .then(function (r) { return r.text(); })
        .then(function (html) {
            var doc = new DOMParser().parseFromString(html, "text/html");
            var remote = doc.getElementById("dataList_{{list.id}}");
            var rt = remote ? remote.querySelector(".table") : null;
            if (!rt) return;
            var trs = rt.querySelectorAll("tbody tr");
            var lastRows = 0;
            for (var x = 0; x < trs.length; x++) {
                if (trs[x].classList && trs[x].classList.contains("expandable-content-row")) continue;
                lastRows++;
            }
            if (!lastRows) return;
            var total = ((lastPage - 1) * pageSize) + lastRows;
            try { sessionStorage.setItem(cacheKey, String(total)); } catch (e) {}
            show(total);
        })
        .catch(function () {});
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

/* Sortable column headers */
#dataList_{{list.id}} thead th.sortable {
    cursor: pointer;
    white-space: nowrap;
}
#dataList_{{list.id}} thead th.sortable a.sort-link {
    color: inherit;
    text-decoration: none;
}
#dataList_{{list.id}} thead th.sortable a.sort-link:hover {
    text-decoration: underline;
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

    // Empty state row
    var tbody = table.querySelector('tbody');
    if (tbody && tbody.querySelectorAll('tr.data-row').length === 0) {
        var headerCells = table.querySelectorAll('thead tr:first-child th');
        var emptyTr = document.createElement('tr');
        emptyTr.className = 'empty';
        var emptyTd = document.createElement('td');
        emptyTd.colSpan = headerCells.length;
        emptyTd.textContent = 'Nothing found to display.';
        emptyTr.appendChild(emptyTd);
        tbody.appendChild(emptyTr);
    }

    // Sortable column headers
    var sortParamName = '${_sortParam?js_string}';
    var orderParamName = '${_orderParam?js_string}';
    var pageParamName = '${_pageParam?js_string}';
    var currentSortIdx = parseInt('${_curSort?js_string}') || 0;
    var currentOrder = '${_curOrder?js_string}';
    var ASC = '2', DESC = '1';
    var sortableIds = [<#list _sortableIds as _id>'${_id?js_string}'<#sep>, </#list>];

    // Build a 1-based sort index map using only actual datalist column headers (ignore selector/actions columns)
    var headerCells = Array.prototype.slice.call(listEl.querySelectorAll('thead tr:first-child th'));
    var columnHeaders = headerCells
        .map(function(th) {
            var m = (th.className || '').match(/\bheader_([^\s]+)/);
            return m ? { th: th, id: m[1] } : null;
        })
        .filter(Boolean);

    columnHeaders.forEach(function(item, idx) {
        if (sortableIds.indexOf(item.id) === -1) return;

        var th = item.th;
        var sortIdx = idx + 1; // 1-based index among DataList columns only
        var isCurrentSort = (currentSortIdx === sortIdx);

        var urlParams = new URLSearchParams(window.location.search);
        urlParams.set(sortParamName, String(sortIdx));
        urlParams.set(pageParamName, '1');
        urlParams.set(orderParamName, isCurrentSort ? (currentOrder === DESC ? ASC : DESC) : ASC);

        th.classList.add('sortable');
        if (isCurrentSort) {
            th.classList.add('sorted');
            th.classList.add(currentOrder === DESC ? 'order1' : 'order2');
        }
        th.innerHTML = '<a href="?' + urlParams.toString() + '" class="sort-link">' + th.innerHTML + '</a>';
    });
})();
</script>
