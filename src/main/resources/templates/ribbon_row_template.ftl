<style>
    #dataList_{{list.id}} .list-group-item.data-row {
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        margin-bottom: 20px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06);
        padding: 0;
        background: #ffffff;
        position: relative;
        overflow: visible; /* allow dropdown menus to extend outside card */
    }

    #dataList_{{list.id}} .list-group-item.data-row {
        --card-color: ${element.properties.ribbonRowAllOtherCardsColor!allOtherCardsColor!'#dbeafe'};
    }

    #dataList_{{list.id}} .list-group-item.data-row::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background: var(--card-color);
        border-top-left-radius: 12px;
        border-bottom-left-radius: 12px;
        z-index: 1;
    }

    #dataList_{{list.id}} .list-card-container {
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    #dataList_{{list.id}} .list-card-header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 20px;
        min-width: 100%;
        overflow-x: auto;
        overflow-y: visible;
        -webkit-overflow-scrolling: touch;
        scrollbar-width: thin;
        scrollbar-color: var(--card-color) #f1f5f9;
        padding-bottom: 12px;
        margin-bottom: 8px;
    }

    #dataList_{{list.id}} .list-card-header::-webkit-scrollbar {
        height: 10px;
    }

    #dataList_{{list.id}} .list-card-header::-webkit-scrollbar-track {
        background: linear-gradient(to right, #f3f4f6, #f9fafb);
        border-radius: 10px;
        margin: 0 4px;
        box-shadow: inset 0 0 3px rgba(0,0,0,0.05);
    }

    #dataList_{{list.id}} .list-card-header::-webkit-scrollbar-thumb {
        background: var(--card-color);
        border-radius: 10px;
        border: 2px solid #f3f4f6;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
    }

    #dataList_{{list.id}} .list-card-header::-webkit-scrollbar-thumb:hover {
        opacity: 0.9;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        transform: scaleY(1.1);
    }

    #dataList_{{list.id}} .list-card-header::-webkit-scrollbar-thumb:active {
        opacity: 0.8;
    }

    #dataList_{{list.id}} .list-card-left-section {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 0;
        align-items: flex-start;
        margin-top: 0;
        padding-right: 10px;
    }

    #dataList_{{list.id}} .list-card-left-section .me-2 {
        margin-bottom: 8px;
    }

    #dataList_{{list.id}} .list-card-middle-section {
        flex: 0 0 auto;
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        min-width: 150px;
        padding: 0 20px;
        justify-content: flex-start;
        flex-shrink: 0;
        padding-right: 15px;
        align-self: flex-start;
    }

    #dataList_{{list.id}} .list-card-title-row {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
        margin-top: 0;
        min-height: 26px;
        width: 100%;
    }

    #dataList_{{list.id}} .list-card-title-icon {
        font-size: 18px;
        color: #080808;
        display: inline-flex;
        align-items: center;
        line-height: 1.2;
        font-family: cursive;
    }

    #dataList_{{list.id}} .list-card-title-icon img {
        width: 18px;
        height: 18px;
        object-fit: contain;
    }

    #dataList_{{list.id}} .list-card-name {
        font-size: 20px;
        font-weight: 700;
        color: #ec4899;
        line-height: 1.3;
        display: inline;
        letter-spacing: -0.3px;
    }

    #dataList_{{list.id}} .list-card-separator-line {
        font-size: 14px;
        color: #6b7280;
        line-height: 1.4;
        margin-bottom: 10px;
        margin-top: 3px;
        min-height: 20px;
    }

    #dataList_{{list.id}} .list-card-email {
        font-size: 14px;
        color: #374151;
        display: inline;
        font-style: italic;
    }

    #dataList_{{list.id}} .list-card-userid {
        font-size: 14px;
        color: #374151;
        display: inline;
        font-style: italic;
    }

    #dataList_{{list.id}} .list-card-email-separator {
        display: inline;
        color: #374151;
        margin: 0 8px;
        font-style: italic;
    }

    #dataList_{{list.id}} .list-card-middle-fields {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        gap: 15px;
        padding-top: 42px;
    }

    #dataList_{{list.id}} .list-card-middle-field {
        font-size: 14px;
        color: #6b7280;
        line-height: 1.4;
        display: inline;
        font-family: cursive;
    }

    #dataList_{{list.id}} .list-card-middle-separator {
        display: inline;
        color: #1f2937;
        margin: 0 8px;
    }

    #dataList_{{list.id}} .list-card-last-section {
        flex: 0 0 auto;
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        min-width: 150px;
        padding: 0 20px;
        justify-content: flex-start;
        align-self: flex-start;
        flex-shrink: 0;
        padding-left: 15px;
    }

    #dataList_{{list.id}} .list-card-last-field {
        font-size: 14px;
        color: #1f2937;
        line-height: 1.5;
        display: inline-block;
        font-weight: 500;
        padding: 10px 18px;
        background: linear-gradient(to right, #f9fafb 0%, #ffffff 100%);
        border-radius: 8px;
        border-left: 4px solid #f5c778;
        white-space: nowrap;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        transition: all 0.2s ease;
    }

    #dataList_{{list.id}} .list-card-last-field:hover {
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        transform: translateX(2px);
    }

    #dataList_{{list.id}} .list-card-right-section {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 0;
        flex-shrink: 0;
        min-width: 200px;
        width: auto;
        padding-left: 15px;
        align-self: flex-start;
    }

    #dataList_{{list.id}} .list-card-right-top {
        text-align: right;
        font-size: 14px;
        color: #a78bfa;
        word-break: break-word;
        margin-bottom: 0;
        min-height: 0;
        line-height: 1.2;
        display: flex;
        align-items: center;
        font-style: italic;
    }

    #dataList_{{list.id}} .list-card-badges {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
        justify-content: flex-end;
        margin-top: 5px;
        margin-right: 0;
    }

    #dataList_{{list.id}} .list-card-badge {
        padding: 8px 14px 8px 24px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        white-space: nowrap;
        display: inline-block;
        position: relative;
        box-shadow: 0 1px 3px rgba(0,0,0,0.12);
        transition: all 0.2s ease;
    }

    #dataList_{{list.id}} .list-card-badge:hover {
        transform: translateY(-1px);
        box-shadow: 0 2px 6px rgba(0,0,0,0.18);
    }

    #dataList_{{list.id}} .list-card-badge::before {
        content: '';
        position: absolute;
        left: 8px;
        top: 50%;
        transform: translateY(-50%);
        width: 6px;
        height: 6px;
        background: #ffffff;
        border-radius: 50%;
    }

    #dataList_{{list.id}} .list-card-badge.role {
        background: #14b8a6;
        color: #ffffff;
    }

    #dataList_{{list.id}} .list-card-badge.status {
        background: #14b8a6;
        color: #ffffff;
    }

    #dataList_{{list.id}} .list-card-right-bottom {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        color: #6b7280;
        line-height: 1.4;
        min-height: 0;
        margin-bottom: 15px;
        margin-top: 3px;
        margin-right: 0;
        font-weight: 500;
        letter-spacing: 0.3px;
    }

    #dataList_{{list.id}} .list-card-footer {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding-top: 8px;
        padding-bottom: 4px;
        border-top: 1px solid #f3f4f6;
        margin-top: 4px;
    }

    /* Footer aligned to left when actionsStyle = bottomActions */
    #dataList_{{list.id}} .list-card-footer.footer-left {
        justify-content: flex-start;
    }

    #dataList_{{list.id}} .list-card-phone {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 8px;
        color: #6b7280;
        font-size: 14px;
        flex-wrap: wrap;
    }

    #dataList_{{list.id}} .list-card-phone > * {
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    #dataList_{{list.id}} .list-card-phone i {
        font-size: 16px;
    }

    #dataList_{{list.id}} .list-card-actions {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    #dataList_{{list.id}} .list-card-actions a {
        color: #ffffff;
        font-size: 16px;
        text-decoration: none;
        transition: color 0.2s;
    }

    #dataList_{{list.id}} .list-card-actions a:hover {
        color: #1f2937;
    }

    .rowActions.d-flex {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .rowActions.d-flex > a {
        color: #ffffff;
        font-size: 12px;
        font-weight: 600;
        text-decoration: none;
        padding: 6px 14px;
        border-radius: 6px;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 1px 3px rgba(0,0,0,0.12);
        letter-spacing: 0.2px;
        line-height: 1.2;
    }

    .rowActions.d-flex > a:hover {
        color: #ffffff;
        opacity: 0.95;
        transform: translateY(-1px);
        box-shadow: 0 2px 6px rgba(0,0,0,0.18);
    }

    .rowActions.d-flex > a:active {
        transform: translateY(0);
        box-shadow: 0 1px 2px rgba(0,0,0,0.12);
    }

    @media (max-width: 767.98px) {
        #dataList_{{list.id}} .list-card-header {
            flex-direction: column;
        }

        #dataList_{{list.id}} .list-card-middle-section {
            padding: 0;
            width: 100%;
        }

        #dataList_{{list.id}} .list-card-right-section {
            align-items: flex-start;
            width: 100%;
        }

        #dataList_{{list.id}} .list-card-right-top {
            text-align: left;
        }

        #dataList_{{list.id}} .list-card-badges {
            justify-content: flex-start;
        }
    }
</style>

<div class="list-group p-0 border-0">
    {{rows data-cbuilder-highlight="@@datalist.simpleListTemplate.list@@" data-cbuilder-style="[{'prefix' : 'list', 'class' : '.list-group-item', 'label' : '@@datalist.simpleListTemplate.list@@'}]"}}
        <div class="data-row list-group-item ${actionsStyle!""}" style="position:relative">
            <div class="list-card-container">
                <!-- Header Section: Left, Middle, and Right Sections -->
                <div class="list-card-header">
                    <div class="list-card-left-section">
                        {{selector}}
                            <div class="me-2">{{body}}</div>
                        {{selector}}

                        <div class="list-card-title-row">
                            {{column_title data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.title@@"}}
                                <span class="list-card-name" data-column-id="title">{{body||@@datalist.simpleCardTemplate.title@@}}</span>
                            {{column_title}}
                        </div>

                        <div class="list-card-left-fields" style="display: flex; flex-direction: row; align-items: center; gap: 0; margin-top: 12px;">
                            {{column_leftfield1 data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <span style="font-size: 14px; color: #374151; line-height: 1.4; display: inline; font-style: italic;" data-column-id="leftfield1">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                            {{column_leftfield1}}
                            <span style="display: inline; color: #374151; margin: 0 8px; font-style: italic;">${separator!'-'}</span>
                            {{column_leftfield2 data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <span style="font-size: 14px; color: #374151; line-height: 1.4; display: inline; font-style: italic;" data-column-id="leftfield2">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                            {{column_leftfield2}}
                        </div>
                    </div>

                    <div class="list-card-middle-section">
                        <div class="list-card-middle-fields">
                            {{column_field1 data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <span class="list-card-middle-field" data-column-id="field1">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                            {{column_field1}}
                            {{column_field2 data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <span class="list-card-middle-field" data-column-id="field2">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                            {{column_field2}}
                        </div>
                    </div>

                    <div class="list-card-right-section">
                        {{column_rightbottom data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                            <div class="list-card-right-bottom" data-column-id="rightbottom">{{body||@@datalist.simpleCardTemplate.textContent@@}}</div>
                        {{column_rightbottom}}

                    <div class="list-card-badges" data-cbuilder-sort-horizontal>
                        {{column_role data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                            <span class="list-card-badge role" data-column-id="role">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                        {{column_role}}
                        {{column_status data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                            <span class="list-card-badge status" data-column-id="status">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                        {{column_status}}
                    </div>
                </div>

                    <div class="list-card-middle-section list-card-last-section">
                        <div class="list-card-middle-fields">
                            {{column_field1 data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <span class="list-card-last-field" data-column-id="field1">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                            {{column_field1}}
                        </div>
                                </div>
                </div>

                <!-- Footer Section: Actions -->
                <#assign actionsStyleValue = actionsStyle!"" />
                <div class="list-card-footer<#if actionsStyleValue == 'bottomActions'> footer-left</#if>">
                    <div class="list-card-actions">
                        <#if actionsStyleValue == 'normalActions' || actionsStyleValue == 'bottomActions'>
                            {{rowActions}}
                                <div class="rowActions d-flex" data-cbuilder-sort-horizontal>{{rowAction}}</div>
                            {{rowActions}}
                        <#else>
                            {{rowActions attr-class="dropdown-item"}}
                            <div class="dropdown">
                                <a data-toggle="dropdown" class="text-muted" tabindex="0" style="cursor:pointer;">
                                    <i class="fa fa-ellipsis-h"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right rowActions">
                                    {{rowAction}}
                                </div>
                            </div>
                            {{rowActions}}
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    {{rows}} 
<script>
    (function() {
        // Helper function to darken a hex color
        function darkenColor(hex, percent) {
            var num = parseInt(hex.replace("#",""), 16);
            var amt = Math.round(2.55 * percent);
            var R = (num >> 16) + amt;
            var G = (num >> 8 & 0x00FF) + amt;
            var B = (num & 0x0000FF) + amt;
            return "#" + (0x1000000 + (R < 255 ? R < 1 ? 0 : R : 255) * 0x10000 +
                (G < 255 ? G < 1 ? 0 : G : 255) * 0x100 +
                (B < 255 ? B < 1 ? 0 : B : 255)).toString(16).slice(1);
        }
        
        var listDiv = document.getElementById("dataList_{{list.id}}");
        if (listDiv === null) {
            return;
        }

        // Values from plugin properties - access directly from element.properties
        <#assign conditionGridRaw = element.properties.ribbonRowConditionGrid!"" />
        <#assign otherColorProp = element.properties.ribbonRowAllOtherCardsColor!allOtherCardsColor!"#dbeafe" />

        var conditions = [];
            
            <#if conditionGridRaw?is_sequence>
                // Repeater is stored as sequence - iterate and build array
                <#list conditionGridRaw as condition>
                conditions.push({
                    conditionColumnId: '${(condition.gridColumnId!"")?js_string}',
                    conditionValue: '${(condition.gridValue!"")?js_string}',
                    cardColor: '${(condition.gridColor!"")?js_string}'
                });
                </#list>
            <#elseif conditionGridRaw?is_string && conditionGridRaw != "">
                // Repeater is stored as JSON string - try to parse it
                try {
                    var parsed = JSON.parse('${conditionGridRaw?js_string}');
                    if (Array.isArray(parsed)) {
                        conditions = parsed.map(function(cond) {
                            return {
                                conditionColumnId: cond.gridColumnId || cond.conditionColumnId || '',
                                conditionValue: cond.gridValue || cond.conditionValue || '',
                                cardColor: cond.gridColor || cond.cardColor || ''
                            };
                        });
                    }
                } catch (e) {
                    // Silently fail if JSON parsing fails
                }
            </#if>
            
            var defaultColor = '${otherColorProp?js_string}' || '#dbeafe';

            // Helper function to extract column value from row (similar to PricingCard)
            function extractColumnValue(row, columnId) {
                if (!columnId || !columnId.trim()) {
                    return '';
                }
                
                var val = '';
                var $row = $(row);
                
                // Method 1: Joget renders columns with class pattern: column_{columnId}
                var columnClass = 'column_' + columnId;
                var $columnEl = $row.find('.' + columnClass);
                if ($columnEl.length > 0) {
                    val = $columnEl.first().text().trim();
                    if (val) {
                        return val;
                    }
                }
                
                // Method 2: Check for class containing the column ID (case-insensitive)
                var allElements = row.querySelectorAll('*');
                for (var i = 0; i < allElements.length; i++) {
                    var el = allElements[i];
                    var className = el.className || '';
                    if (className.indexOf('column_' + columnId) !== -1 ||
                        className.indexOf('column_' + columnId.toLowerCase()) !== -1 ||
                        className.indexOf('column_' + columnId.toUpperCase()) !== -1) {
                        val = el.textContent || el.innerText || '';
                        if (val) {
                            return val.trim();
                        }
                    }
                }
                
                // Method 3: Look for data-column-id attribute
                var $dataColumnEl = $row.find('[data-column-id="' + columnId + '"]');
                if ($dataColumnEl.length > 0) {
                    val = $dataColumnEl.first().text().trim();
                    if (val) {
                        return val;
                    }
                }
                
                // Method 4: Search all elements for data attributes with column ID
                for (var i = 0; i < allElements.length; i++) {
                    var el = allElements[i];
                    var colId = el.getAttribute('data-column-id') || 
                               el.getAttribute('data-field') || 
                               el.getAttribute('data-name') || '';
                    if (colId.toLowerCase() === columnId.toLowerCase()) {
                        val = el.textContent || el.innerText || '';
                        if (val) {
                            return val.trim();
                        }
                    }
                }
                
                return '';
            }

            // Hide icon when span is empty (replaces the FreeMarker conditional)
            $(listDiv).find('.list-card-phone').each(function(){
                $(this).find('span').each(function(){
                    if ($(this).text().trim() === '') {
                        $(this).prev('i').hide();
                        $(this).hide();
                    }
                });
            });

            // Create a single style element for all row colors
            var styleId = 'ribben-row-colors-{{list.id}}';
            var $styleEl = $('#' + styleId);
            if ($styleEl.length === 0) {
                $styleEl = $('<style id="' + styleId + '"></style>').appendTo('head');
            }
            var styleRules = [];

            var rows = listDiv.querySelectorAll('.list-group-item.data-row');
            
            // Apply conditional colors to cards
            if (conditions && conditions.length > 0) {
                rows.forEach(function(row, index) {
                    var $row = $(row);
                    var matched = false;
                    var matchedColor = defaultColor;
                    
                    // Check each condition in the grid
                    for (var i = 0; i < conditions.length; i++) {
                        var condition = conditions[i];
                        var conditionColumnId = (condition.conditionColumnId || '').trim();
                        var conditionValue = (condition.conditionValue || '').trim();
                        var cardColor = (condition.cardColor || '').trim();
                        
                        if (!conditionColumnId || !conditionValue) {
                            continue;
                        }
                        
                        // Extract value from row for this condition's column
                        var rowValue = extractColumnValue(row, conditionColumnId);
                        
                        // Exact, case-sensitive match
                        if (rowValue === conditionValue) {
                            matched = true;
                            matchedColor = cardColor || defaultColor;
                            break; // Use first match
                        }
                    }
                    
                    // Apply the matched color or default
                    var finalColor = matched ? matchedColor : defaultColor;
                    var darkerColor = darkenColor(finalColor, -15); // Darken by 15%
                    var rowIndex = index + 1;
                    
                    $row.css('--card-color', finalColor);
                    $row.css('--card-color-dark', darkerColor);
                    
                    // Add style rule for this row
                    styleRules.push('#dataList_{{list.id}} .list-group-item.data-row:nth-child(' + rowIndex + ')::before { background: linear-gradient(to bottom, ' + finalColor + ', ' + darkerColor + '); }');
                });
            } else {
                // No conditions, apply default color to all rows
                var darkerDefault = darkenColor(defaultColor, -15);
                rows.forEach(function(row, index) {
                    var $row = $(row);
                    var rowIndex = index + 1;
                    $row.css('--card-color', defaultColor);
                    $row.css('--card-color-dark', darkerDefault);
                    styleRules.push('#dataList_{{list.id}} .list-group-item.data-row:nth-child(' + rowIndex + ')::before { background: linear-gradient(to bottom, ' + defaultColor + ', ' + darkerDefault + '); }');
                });
            }
            
            // Apply all style rules at once
            if (styleRules.length > 0) {
                $styleEl.text(styleRules.join('\n'));
            }
        })();
    </script>
</div>   

