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
