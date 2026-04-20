<div class="table-responsive">
    <table class="table table-hover">
        <thead>
        {{columns data-cbuilder-sort-horizontal data-cbuilder-prepend data-cbuilder-style="[{'class' : 'td', 'label' : 'Body'}, {'prefix' : 'header', 'class' : 'th', 'label' : 'Header'}]"}}
        <tr>
            {{selector}}
            <th style="width: 40px;">{{body}}</th>
            {{selector}}
            {{column}}
            <th>
                {{label||Sample Label}}
                <span class="overlay"></span>
            </th>
            {{column}}
            <th class="gap"></th>
            {{rowActions data-cbuilder-sort-horizontal data-cbuilder-style="[{'class' : '.rowAction_body', 'label' : 'Body'}, {'prefix' : 'header', 'class' : '.rowAction_header', 'label' : 'Header'}, {'prefix' : 'link', 'class' : '.rowAction_body > a', 'label' : 'Link'}]"}}
            <th class="sapr-actions-column">
                {{rowAction}}
                <div class="rowAction rowAction_header" data-cbuilder-visible>
                    {{header_label|| }}
                    <span class="overlay"></span>
                </div>
                {{rowAction}}
            </th>
            {{rowActions}}
        </tr>
        {{columns}}
        </thead>
        <tbody>
        {{rows data-cbuilder-sync}}
        {{columns data-cbuilder-sync}}
        <tr>
            {{selector}}
            <td>{{body}}</td>
            {{selector}}
            {{column}}
            <td>{{body||Sample Value}}</td>
            {{column}}
            <td class="gap"></td>
            {{rowActions data-cbuilder-sync}}
            <td class="sapr-actions-column">
                {{rowAction}}
                <div class="rowAction rowAction_body">
                    {{body}}
                </div>
                {{rowAction}}
            </td>
            {{rowActions}}
        </tr>
        {{columns}}
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

    var table = listEl.querySelector(".table");
    var rows = table ? table.querySelectorAll("tbody tr") : [];
    var n = 0;
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].classList && rows[i].classList.contains("expandable-content-row")) continue;
        n++;
    }
    if (!n) { infoEl.textContent = ""; return; }

    var url = new URL(window.location.href);
    var sp = url.searchParams;
    function int(v, d) { v = parseInt(v, 10); return isNaN(v) ? d : v; }
    var page = int(sp.get("page") || sp.get("p"), 1);
    var pageSize = int(sp.get("pageSize") || sp.get("rows"), n);
    var start = ((page - 1) * pageSize) + 1;
    var end = start + n - 1;
    infoEl.textContent = "Displaying " + start + " to " + end + ".";
})();
</script>

<style>
    /* Ensure horizontal scroll so sticky column works (design + preview) */
    #dataList_{{list.id}} .table-responsive {
        overflow-x: auto !important;
        -webkit-overflow-scrolling: touch;
    }

    /* Sticky Actions column (design + preview) */
    #dataList_{{list.id}} .sapr-actions-column,
    .table-responsive .sapr-actions-column {
        position: sticky !important;
        right: 0 !important;
        z-index: 10 !important;
        background: #fff !important;
        box-shadow: -4px 0 8px rgba(0, 0, 0, 0.06);
    }
    #dataList_{{list.id}} .table thead .sapr-actions-column,
    .table-responsive .table thead .sapr-actions-column {
        background: #f8f9fa !important;
    }
    #dataList_{{list.id}} .table tbody tr:hover .sapr-actions-column,
    .table-responsive .table tbody tr:hover .sapr-actions-column {
        background: #f1f3f5 !important;
    }
    body.rtl #dataList_{{list.id}} .sapr-actions-column,
    body.rtl .table-responsive .sapr-actions-column {
        right: auto !important;
        left: 0 !important;
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
