<#assign _dl = element.datalist />
<#assign _hideUnselectedActions = ((element.properties.hideActionsWhenUnselected!'') == 'true') />
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

<#--
    Result info line, rendered entirely server-side.
    The DataList already knows the filtered total (getSize()), the page size,
    and the current page, so there is no need to reverse-engineer these values
    on the client by fetching the last page. This is accurate under filtering /
    search and requires no extra HTTP request.
-->
<#assign _total = _dl.getSize() />
<#assign _pageSize = _dl.getPageSize() />
<#assign _pageStr = (_dl.getDataListParamString("p"))!"" />
<#assign _page = (_pageStr?trim?matches(r"^[0-9]+$"))?then(_pageStr?number?int, 1) />
<#if _page lt 1><#assign _page = 1 /></#if>
<#if (_pageSize gt 0)>
    <#assign _start = ((_page - 1) * _pageSize) + 1 />
    <#assign _end = _page * _pageSize />
    <#if (_end gt _total)><#assign _end = _total /></#if>
<#else>
    <#assign _start = (_total gt 0)?then(1, 0) />
    <#assign _end = _total />
</#if>
<#if (_start gt _total)><#assign _start = _total /></#if>
<div id="datalistInfo_{{list.id}}" class="datalist-result-info" style="text-align:right; padding: 2px 0 6px; font-size: 12px; color: #6c757d;"><#if (_total gt 0)>${_total?c} items found, displaying ${_start?c} to ${_end?c}.<#else>No items found.</#if></div>

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

/* Actions disabled until row selection */
#dataList_{{list.id}} .sapr-action-disabled,
#dataList_{{list.id}} .actions button.form-button:disabled {
    opacity: 0.45;
    cursor: not-allowed !important;
    pointer-events: none;
}
</style>

<script>
(function() {
    var listEl = document.getElementById("dataList_{{list.id}}");
    if (!listEl) return;

    var table = listEl.querySelector(".table");
    if (!table) return;

    var theadCheckbox = table.querySelector("thead .sapr-select-all-header input[type='checkbox']");
    var rowSelectors = function() {
        return table.querySelectorAll(
            "tbody tr .select_checkbox input[type='checkbox'], " +
            "tbody tr .select_radio input[type='radio'], " +
            "tbody tr td:first-child input[type='checkbox'], " +
            "tbody tr td:first-child input[type='radio']"
        );
    };
    var rowCheckboxes = rowSelectors;
    var hasRowSelector = rowSelectors().length > 0;
    var hideActionsWhenUnselected = ${_hideUnselectedActions?string('true', 'false')};

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

    function isSelectorChecked(input) {
        return !!(input && !input.disabled && input.checked);
    }

    function hasAnyRowSelected() {
        var selectors = rowSelectors();
        for (var i = 0; i < selectors.length; i++) {
            if (isSelectorChecked(selectors[i])) return true;
        }
        return false;
    }

    function setActionElementState(el, disabled) {
        if (!el || el.classList.contains("sapr-action-skip")) return;

        if (hideActionsWhenUnselected && disabled) {
            el.style.display = "none";
            el.classList.add("sapr-action-hidden");
            if (el.tagName === "A") {
                if (!el.hasAttribute("data-sapr-original-href")) {
                    el.setAttribute("data-sapr-original-href", el.getAttribute("href") || "");
                    if (el.getAttribute("onclick")) {
                        el.setAttribute("data-sapr-original-onclick", el.getAttribute("onclick"));
                    }
                }
                el.removeAttribute("href");
                el.setAttribute("onclick", "return false;");
            } else if (el.tagName === "BUTTON" || (el.tagName === "INPUT" && (el.type === "submit" || el.type === "button"))) {
                el.disabled = true;
            }
            return;
        }

        el.style.display = "";
        el.classList.remove("sapr-action-hidden");

        if (el.tagName === "A") {
            if (disabled) {
                if (!el.hasAttribute("data-sapr-original-href")) {
                    el.setAttribute("data-sapr-original-href", el.getAttribute("href") || "");
                    if (el.getAttribute("onclick")) {
                        el.setAttribute("data-sapr-original-onclick", el.getAttribute("onclick"));
                    }
                }
                el.removeAttribute("href");
                el.setAttribute("onclick", "return false;");
                el.classList.add("sapr-action-disabled");
                el.setAttribute("aria-disabled", "true");
                el.setAttribute("tabindex", "-1");
            } else {
                if (el.hasAttribute("data-sapr-original-href")) {
                    el.setAttribute("href", el.getAttribute("data-sapr-original-href"));
                }
                if (el.hasAttribute("data-sapr-original-onclick")) {
                    el.setAttribute("onclick", el.getAttribute("data-sapr-original-onclick"));
                } else {
                    el.removeAttribute("onclick");
                }
                el.classList.remove("sapr-action-disabled");
                el.removeAttribute("aria-disabled");
                el.removeAttribute("tabindex");
            }
            return;
        }

        if (el.tagName === "BUTTON" || (el.tagName === "INPUT" && (el.type === "submit" || el.type === "button"))) {
            el.disabled = disabled;
            el.classList.toggle("sapr-action-disabled", disabled);
        }
    }

    function listActionRequiresSelection(btn) {
        var href = (btn.getAttribute("data-href") || "").trim();
        var hrefParam = (btn.getAttribute("data-hrefparam") || "").trim();
        var target = (btn.getAttribute("data-target") || "").trim().toLowerCase();
        // Match Joget datalist logic: hyperlink actions without hrefParam do not need row selection (e.g. Add New Record).
        if (href && !hrefParam && target !== "post") {
            return false;
        }
        return true;
    }

    function syncActionStates() {
        if (!hasRowSelector) return;

        var anySelected = hasAnyRowSelected();
        var listButtons = listEl.querySelectorAll("form .actions button.form-button");
        for (var b = 0; b < listButtons.length; b++) {
            var btn = listButtons[b];
            if (!listActionRequiresSelection(btn)) {
                setActionElementState(btn, false);
                continue;
            }
            setActionElementState(btn, !anySelected);
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
            syncActionStates();
        });
    }

    table.addEventListener("change", function(e) {
        if (!e.target) return;
        var isRowSelectorEvent = (
            (e.target.type === "checkbox" || e.target.type === "radio") &&
            e.target.closest("tbody tr")
        );
        if (isRowSelectorEvent) {
            syncHeaderFromRows();
            syncActionStates();
        }
    });

    syncHeaderFromRows();
    syncActionStates();

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
    var curSortRaw = '${_curSort?js_string}';
    var currentSortIdx = curSortRaw !== '' ? parseInt(curSortRaw, 10) : null;
    var currentOrder = '${_curOrder?js_string}';
    var ASC = '2', DESC = '1';
    var sortableIds = [<#list _sortableIds as _id>'${_id?js_string}'<#sep>, </#list>];

    // Sort-index base must match DataList.getDataListParam(): the backend subtracts 1
    // from the sort param only when the checkbox column is on the LEFT or BOTH sides,
    // then indexes into the (selector-less) data column array. So the value we emit is
    // 1-based when the selector is left/both, and 0-based otherwise (selector off or right).
    <#assign _cbPos = (_dl.getCheckboxPosition())!"left" />
    <#assign _sortBase = (_cbPos == "left" || _cbPos == "both")?then(1, 0) />
    var sortBase = ${_sortBase?c};

    // Build the sort index map using only actual datalist column headers (ignore selector/actions columns)
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
        var sortIdx = idx + sortBase; // base depends on checkbox position (see above)
        var isCurrentSort = (currentSortIdx !== null && currentSortIdx === sortIdx);

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
