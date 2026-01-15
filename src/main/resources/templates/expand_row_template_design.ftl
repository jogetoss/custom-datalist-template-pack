<div class="table-responsive">
    <table class="table table-hover">
        <thead>
        {{columns data-cbuilder-sort-horizontal data-cbuilder-prepend data-cbuilder-style="[{'class' : 'td', 'label' : 'Body'}, {'prefix' : 'header', 'class' : 'th', 'label' : 'Header'}]"}}
        <tr>
            <th class="expand-icon-column" style="width: 30px; padding: 8px 4px; text-align: left !important;"></th>
            {{column}}
            <th>
                {{label||Sample Label}}
                <span class="overlay"></span>
            </th>
            {{column}}
            <th class="gap"></th>
            {{rowActions data-cbuilder-sort-horizontal data-cbuilder-style="[{'class' : '.rowAction_body', 'label' : 'Body'}, {'prefix' : 'header', 'class' : '.rowAction_header', 'label' : 'Header'}, {'prefix' : 'link', 'class' : '.rowAction_body > a', 'label' : 'Link'}]"}}
            <th>
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
            <td class="expand-icon-column" style="padding: 8px 4px; text-align: left !important;">
                <i class="expand-toggle-icon ${expandIcon!"fas fa-chevron-right"}" onclick="toggleRowExpansion(this);" data-expanded="false"></i>
            </td>
            {{column}}
            <td>{{body||Sample Value}}</td>
            {{column}}
            <td class="gap"></td>
            {{rowActions data-cbuilder-sync}}
            <td>
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

<!-- Hidden expandable data for each row -->
<div style="display: none;">
    {{rows}}
    <div class="expandable-data" data-row-id="{{id}}">
        <#assign fieldsCount = (expandableFieldsCount!"5")?number>
        <#list 1..fieldsCount as i>
            {{column_expandable_${i}}}
            <div class="expandable-field-data" data-column="${i}">
                <span class="field-label">{{label||Expandable Column ${i}}}</span>
                <div class="field-value">{{body||No data}}</div>
            </div>
            {{column_expandable_${i}}}
        </#list>
    </div>
    {{rows}}
</div>

<!-- Design Mode: Expandable Columns Configuration -->
<#if element??>
    <div class="expandable-columns-config" style="margin-top: 20px; padding: 15px; background: #f8f9fa; border: 2px dashed #dee2e6; border-radius: 8px;">
        <h6 style="color: #495057; margin-bottom: 15px;"><i class="fas fa-cog"></i> Expandable Columns Configuration</h6>
        <div class="row">
            <#assign fieldsCount = (expandableFieldsCount!"5")?number>
            <#list 1..fieldsCount as i>
                <div class="col-lg-4 col-md-6">
                    {{column_expandable_${i} data-cbuilder-droparea-msg="Expandable Column ${i}"}}
                    <div class="expandable-drop-zone">
                        <div class="drop-zone-content">
                            <i class="fas fa-plus-circle"></i>
                            <span>{{label||Expandable Column ${i}}}</span>
                            <small>{{body||Drag column here}}</small>
                        </div>
                    </div>
                    {{column_expandable_${i}}}
                </div>
            </#list>
        </div>
    </div>
</#if>

<script>
    // Function to hide/show expandable configuration section
    function toggleConfigVisibility() {
        var configSection = document.querySelector('.expandable-columns-config');

        if (configSection) {
            // Check URL patterns for design mode vs preview mode
            var currentUrl = window.location.href;
            var isDesignMode = false;

            // Design mode URLs contain '/builder/' or '/design/'
            if (currentUrl.includes('/builder/') || currentUrl.includes('/design/')) {
                isDesignMode = true;
            }

            // Preview mode URLs contain '/userview/' - explicitly not design mode
            if (currentUrl.includes('/userview/')) {
                isDesignMode = false;
            }

            if (isDesignMode) {
                // We're in design mode, show the config
                configSection.style.display = 'block';
            } else {
                // We're in preview mode, hide the config
                configSection.style.display = 'none';
            }
        }
    }

    // Run on page load
    document.addEventListener('DOMContentLoaded', toggleConfigVisibility);

    // Run when URL changes (for AJAX navigation)
    window.addEventListener('popstate', toggleConfigVisibility);

    // Run periodically to catch dynamic content changes
    setInterval(toggleConfigVisibility, 1000);

    // Run when any button is clicked (to catch search button)
    document.addEventListener('click', function(event) {
        if (event.target.tagName === 'BUTTON' || event.target.closest('button')) {
            setTimeout(toggleConfigVisibility, 100);
        }
    });

    function toggleRowExpansion(icon) {
        if (window.event) {
            window.event.preventDefault();
            window.event.stopPropagation();
        }

        var currentRow = icon.closest('tr');
        var isExpanded = icon.getAttribute('data-expanded') === 'true';

        if (isExpanded) {
            // Collapse
            var expandableRow = currentRow.nextElementSibling;
            if (expandableRow && expandableRow.classList.contains('expandable-content-row')) {
                expandableRow.remove();
            }
            icon.className = 'expand-toggle-icon ${expandIcon!"fas fa-chevron-right"}';
            icon.setAttribute('data-expanded', 'false');
        } else {
            // Expand
            var newExpandableRow = document.createElement('tr');
            newExpandableRow.className = 'expandable-content-row';

            var rowId = currentRow.getAttribute('data-row-id');
            var expandableDataDiv = document.querySelector('.expandable-data[data-row-id="' + rowId + '"]');
            var expandableFieldsHtml = '';

            if (expandableDataDiv) {
                var expandableFields = expandableDataDiv.querySelectorAll('.expandable-field-data');
                expandableFields.forEach(function(field) {
                    var label = field.querySelector('.field-label');
                    var value = field.querySelector('.field-value');

                    if (label && value) {
                        var name = label.textContent.trim();
                        var val = value.textContent.trim();

                        // Only add fields that are not default placeholders (show even if empty)
                        var isDefaultPlaceholder = false;
                        for (var j = 1; j <= 10; j++) {
                            if (name === 'Expandable Column ' + j) {
                                isDefaultPlaceholder = true;
                                break;
                            }
                        }

                        if (name && !isDefaultPlaceholder) {

                            var displayValue = (val && val !== 'No data' && val.trim() !== '') ? val : '';

                            expandableFieldsHtml += '<div class="expandable-field-item">' +
                                '<span class="field-label">' + name + ':</span>' +
                                '<span class="field-value">' + displayValue + '</span>' +
                                '</div>';
                        }
                    }
                });
            }

            if (expandableFieldsHtml === '') {
                expandableFieldsHtml = '<div class="expandable-field-item"><span class="field-value" style="text-align: center; color: #6c757d;">No additional data available</span></div>';
            }

            var layout = '${layout!"horizontal"}';
            var wrapperClass = layout === 'vertical' ? 'expandable-content-wrapper-vertical' : 'expandable-content-wrapper-horizontal';
            var contentHtml = '';

            if (layout === 'vertical') {
                // Vertical layout: all fields in a single column
                contentHtml = '<div class="expandable-content-wrapper ' + wrapperClass + '">' +
                    '<div class="expandable-column-single">' +
                    expandableFieldsHtml +
                    '</div>' +
                    '</div>';
            } else {
                // Horizontal layout: split fields into two columns (half in left, half in right)
                var fieldsArray = [];
                var tempDiv = document.createElement('div');
                tempDiv.innerHTML = expandableFieldsHtml;
                var fieldItems = tempDiv.querySelectorAll('.expandable-field-item');
                fieldItems.forEach(function(item) {
                    fieldsArray.push(item.outerHTML);
                });

                var midPoint = Math.ceil(fieldsArray.length / 2);
                var leftColumnHtml = fieldsArray.slice(0, midPoint).join('');
                var rightColumnHtml = fieldsArray.slice(midPoint).join('');

                contentHtml = '<div class="expandable-content-wrapper ' + wrapperClass + '">' +
                    '<div class="expandable-column-left">' +
                    leftColumnHtml +
                    '</div>' +
                    '<div class="expandable-column-right">' +
                    rightColumnHtml +
                    '</div>' +
                    '</div>';
            }

            newExpandableRow.innerHTML = '<td colspan="100%" class="expandable-content-cell">' +
                contentHtml +
                '</td>';

            currentRow.parentNode.insertBefore(newExpandableRow, currentRow.nextSibling);
            icon.className = 'expand-toggle-icon ${collapseIcon!"fas fa-chevron-down"}';
            icon.setAttribute('data-expanded', 'true');
        }
    }
</script>

<style>
    /* Expand Toggle Icon Styling */
    .expand-toggle-icon {
        cursor: pointer;
        color: #495057;
        font-size: 14px;
        transition: color 0.2s ease, transform 0.2s ease;
    }
    .expand-toggle-icon:hover {
        color: #212529;
        transform: scale(1.1);
    }

    /* Ensure icon column stays on the left */
    .expand-icon-column {
        position: relative !important;
        z-index: 10 !important;
        text-align: left !important;
        float: none !important;
        order: -1 !important;
    }
    .table > thead > tr > th.expand-icon-column,
    .table > tbody > tr > td.expand-icon-column {
        position: relative !important;
        z-index: 10 !important;
        text-align: left !important;
    }
    .table > tbody > tr > td:first-child {
        text-align: left !important;
        order: -1 !important;
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

    /* Expandable Content */
    .expandable-content-row {
        display: table-row !important;
        visibility: visible !important;
        animation: slideDown 0.3s ease-out;
    }
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    .expandable-content-cell {
        background: #f8f9fa !important;
        border-top: 1px solid #dee2e6 !important;
        padding: 20px 60px !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) inset;
        animation: fadeIn 0.4s ease-out;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
    .expandable-content-wrapper {
        max-width: 100%;
        margin: 0 auto;
    }
    .expandable-field-item {
        display: block;
        margin-bottom: 16px;
        animation: fadeInUp 0.4s ease-out backwards;
    }
    .expandable-field-item:nth-child(1) { animation-delay: 0.05s; }
    .expandable-field-item:nth-child(2) { animation-delay: 0.1s; }
    .expandable-field-item:nth-child(3) { animation-delay: 0.15s; }
    .expandable-field-item:nth-child(4) { animation-delay: 0.2s; }
    .expandable-field-item:nth-child(5) { animation-delay: 0.25s; }
    .expandable-field-item:nth-child(6) { animation-delay: 0.3s; }
    .expandable-field-item:nth-child(n+7) { animation-delay: 0.35s; }
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(8px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    .expandable-content-wrapper-horizontal {
        display: flex;
        gap: 40px;
    }
    .expandable-content-wrapper-vertical {
        display: block;
    }
    .expandable-column-left,
    .expandable-column-right {
        flex: 1;
        min-width: 0;
    }
    .expandable-column-single {
        width: 100%;
    }
    .expandable-field-item:last-child {
        margin-bottom: 0;
    }
    .field-label {
        font-size: 14px;
        color: #212529;
        font-weight: 600;
        margin-right: 4px;
        display: inline;
    }
    .field-value {
        font-size: 14px;
        color: #495057;
        word-break: break-word;
        line-height: 1.5;
        display: inline;
    }
    .expandable-content-wrapper-horizontal .field-label {
        display: block;
        margin-right: 0;
        margin-bottom: 6px;
    }
    .expandable-content-wrapper-horizontal .field-value {
        display: block;
    }
    .expandable-content-wrapper-vertical {
        padding-left: 80px;
    }
    .expandable-content-wrapper-vertical .expandable-field-item {
        display: flex;
        align-items: flex-start;
        gap: 60px;
    }
    .expandable-content-wrapper-vertical .field-label {
        margin-right: 0;
        flex-shrink: 0;
        min-width: 140px;
        display: block;
    }
    .expandable-content-wrapper-vertical .field-value {
        flex: 1;
        display: block;
    }

    /* Design Mode */
    .expandable-columns-config {
        display: block;
    }
    .expandable-drop-zone {
        border: 2px dashed #dee2e6;
        border-radius: 4px;
        padding: 20px;
        text-align: center;
        background: #f8f9fa;
        min-height: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .drop-zone-content {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
    }
    .drop-zone-content i {
        font-size: 24px;
        color: #6c757d;
    }
    .drop-zone-content span {
        font-weight: 600;
        color: #495057;
        font-size: 14px;
    }
    .drop-zone-content small {
        color: #6c757d;
        font-size: 12px;
    }
</style>


