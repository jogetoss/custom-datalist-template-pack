<style>
    /* Container */
    #dataList_{{list.id}} .pricing-table {
        display: flex;
        flex-wrap: wrap;
        gap: 24px;
        align-items: stretch;
        justify-content: center;
        padding-top: 16px; /* add space so first card is not cut off at the top */
    }

    #dataList_{{list.id}} .pricing-card {
        position: relative;
        background: #ffffff;
        border-radius: 16px;
        border: 1px solid rgba(229, 231, 235, 0.8);
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        padding: 28px 26px 24px;
        display: flex;
        flex-direction: column;
        width: 100%;
        max-width: 290px;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        overflow: hidden;
        backdrop-filter: blur(10px);
    }

    <#assign cardsPerRow = (element.properties.cardsPerRow!cardsPerRow!"4")?number>
    <#if cardsPerRow == 1>
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(100% - 0px);
            max-width: 100%;
        }
    <#elseif cardsPerRow == 2>
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(50% - 12px);
            max-width: calc(50% - 12px);
        }
    <#elseif cardsPerRow == 3>
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(33.333% - 16px);
            max-width: calc(33.333% - 16px);
        }
    <#elseif cardsPerRow == 4>
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(25% - 18px);
            max-width: calc(25% - 18px);
        }
    <#elseif cardsPerRow == 5>
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(20% - 19.2px);
            max-width: calc(20% - 19.2px);
        }
    </#if>

    /* Header */
    #dataList_{{list.id}} .pricing-plan-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        color: #6b7280;
        letter-spacing: 0.12em;
        margin-bottom: 8px;
        opacity: 0.8;
        transition: opacity 0.3s;
    }


    #dataList_{{list.id}} .pricing-plan-name {
        font-size: 24px;
        font-weight: 800;
        color: #111827;
        margin-bottom: 6px;
        line-height: 1.2;
        letter-spacing: -0.02em;
        transition: color 0.3s;
    }


    #dataList_{{list.id}} .pricing-plan-subtitle {
        font-size: 14px;
        color: #6b7280;
        min-height: 20px;
        margin-bottom: 16px;
        line-height: 1.5;
        font-weight: 400;
    }

    /* Price */
    #dataList_{{list.id}} .pricing-price-row {
        display: flex;
        align-items: baseline;
        justify-content: flex-start;
        gap: 6px;
        margin-bottom: 8px;
        padding: 12px 0;
        border-bottom: 1px solid rgba(229, 231, 235, 0.5);
    }

    #dataList_{{list.id}} .pricing-price-amount {
        font-size: 32px;
        font-weight: 900;
        color: #111827;
        line-height: 1;
        background: linear-gradient(135deg, #1e40af 0%, #7c3aed 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        transition: transform 0.3s;
    }


    #dataList_{{list.id}} .pricing-price-period {
        font-size: 14px;
        color: #6b7280;
        font-weight: 500;
    }

    #dataList_{{list.id}} .pricing-price-note {
        font-size: 12px;
        color: #10b981;
        font-weight: 600;
        margin-bottom: 16px;
        padding: 6px 12px;
        background: rgba(16, 185, 129, 0.1);
        border-radius: 6px;
        display: inline-block;
        transition: all 0.3s;
    }


    /* Selector / duration dropdown */
    #dataList_{{list.id}} .pricing-duration {
        margin-bottom: 16px;
    }

    #dataList_{{list.id}} .pricing-duration select,
    #dataList_{{list.id}} .pricing-duration .form-control {
        font-size: 13px;
        padding: 8px 12px;
        height: 38px;
        border-radius: 8px;
        border: 1px solid #e5e7eb;
        background: #ffffff;
        transition: all 0.3s;
        font-weight: 500;
    }

    #dataList_{{list.id}} .pricing-duration select:hover,
    #dataList_{{list.id}} .pricing-duration .form-control:hover {
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    #dataList_{{list.id}} .pricing-duration select:focus,
    #dataList_{{list.id}} .pricing-duration .form-control:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    /* Button */
    #dataList_{{list.id}} .pricing-cta {
        margin-bottom: 20px;
    }

    /* Base CTA button style – used as template for row actions */
    #dataList_{{list.id}} .pricing-cta .btn,
    #dataList_{{list.id}} .pricing-cta a {
        width: 100%;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 20px;
        border-radius: 10px;
        text-transform: none;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        white-space: nowrap;
    }

    #dataList_{{list.id}} .pricing-cta .btn::before,
    #dataList_{{list.id}} .pricing-cta a::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s;
    }

    #dataList_{{list.id}} .pricing-cta .btn:hover,
    #dataList_{{list.id}} .pricing-cta a:hover {
        transform: translateY(-2px);
    }

    #dataList_{{list.id}} .pricing-cta .btn:hover::before,
    #dataList_{{list.id}} .pricing-cta a:hover::before {
        left: 100%;
    }

    #dataList_{{list.id}} .pricing-cta .btn:active,
    #dataList_{{list.id}} .pricing-cta a:active {
        transform: translateY(0);
    }

    /* Row Actions container – stack actions vertically with spacing */
    #dataList_{{list.id}} .pricing-cta .rowActions {
        display: flex;
        flex-direction: column;
        gap: 8px;
        width: 100%;
    }

    /* Row Actions Styling – reuse base CTA look */
    #dataList_{{list.id}} .pricing-cta .rowActions a,
    #dataList_{{list.id}} .pricing-cta .rowActions .btn {
        width: 100%;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 20px;
        border-radius: 10px;
        text-transform: none;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        white-space: nowrap;
    }

    #dataList_{{list.id}} .pricing-cta .rowActions a::before,
    #dataList_{{list.id}} .pricing-cta .rowActions .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.5s;
    }

    #dataList_{{list.id}} .pricing-cta .rowActions a:hover,
    #dataList_{{list.id}} .pricing-cta .rowActions .btn:hover {
        transform: translateY(-2px);
    }

    #dataList_{{list.id}} .pricing-cta .rowActions a:hover::before,
    #dataList_{{list.id}} .pricing-cta .rowActions .btn:hover::before {
        left: 100%;
    }

    /* Features */
    #dataList_{{list.id}} .pricing-features {
        list-style: none;
        padding: 0;
        margin: 0 0 18px;
    }

    #dataList_{{list.id}} .pricing-feature-item {
        display: flex;
        align-items: flex-start;
        gap: 8px;
        font-size: 13px;
        color: #374151;
        margin-bottom: 4px;
        padding: 3px 0;
        transition: all 0.2s;
        border-radius: 6px;
        padding-left: 4px;
    }

    #dataList_{{list.id}} .pricing-feature-item:hover {
        background: rgba(59, 130, 246, 0.05);
        transform: translateX(4px);
    }

    #dataList_{{list.id}} .pricing-feature-item i {
        color: #10b981;
        margin-top: 2px;
        min-width: 18px;
        text-align: center;
        font-size: 12px;
        background: rgba(16, 185, 129, 0.1);
        width: 18px;
        height: 18px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        transition: all 0.3s;
    }

    #dataList_{{list.id}} .pricing-feature-item:hover i {
        background: rgba(16, 185, 129, 0.2);
        transform: scale(1.1);
    }

    #dataList_{{list.id}} .pricing-feature-label {
        font-weight: 600;
        margin-right: 4px;
    }

    #dataList_{{list.id}} .pricing-feature-value {
        font-weight: 500;
        color: #4b5563;
        line-height: 1.5;
    }

    /* Footer link */
    #dataList_{{list.id}} .pricing-footer-link {
        margin-top: auto;
        font-size: 12px;
        text-align: center;
        padding-top: 16px;
        border-top: 1px solid rgba(229, 231, 235, 0.5);
    }

    #dataList_{{list.id}} .pricing-footer-link a {
        font-weight: 600;
        color: #3b82f6;
        text-decoration: none;
        transition: all 0.3s;
        position: relative;
        display: inline-block;
    }

    #dataList_{{list.id}} .pricing-footer-link a::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(90deg, #3b82f6, #8b5cf6);
        transition: width 0.3s;
    }

    #dataList_{{list.id}} .pricing-footer-link a:hover {
        color: #2563eb;
        transform: translateY(-2px);
    }

    #dataList_{{list.id}} .pricing-footer-link a:hover::after {
        width: 100%;
    }

    /* Responsive - override cards per row on smaller screens */
    @media (min-width: 768px) and (max-width: 991.98px) {
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 calc(50% - 12px) !important;
            max-width: calc(50% - 12px) !important;
        }
    }

    @media (max-width: 767.98px) {
        #dataList_{{list.id}} .pricing-card {
            flex: 0 0 100% !important;
            max-width: 100% !important;
        }
    }
</style>

<div class="pricing-table">
    {{rows data-cbuilder-highlight="@@datalist.simpleListTemplate.list@@" data-cbuilder-style="[{'prefix' : 'pricing', 'class' : '.pricing-card', 'label' : '@@datalist.simpleListTemplate.list@@'}]"}}
        <#assign conditionColumnId = element.properties.conditionColumnId!conditionColumnId!"" />
        <#assign actionsStyleProp = element.properties.actionsStyle!actionsStyle!"" />
        <div class="data-row pricing-card ${actionsStyleProp}" data-condition-column-id="${conditionColumnId?js_string}">
            <!-- Hidden condition column value - will be populated by JavaScript -->
            <span class="pricing-condition-value" style="display: none;"></span>
            <!-- Plan header -->
            {{column_planLabel data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                <div class="pricing-plan-label">{{body||@@datalist.simpleCardTemplate.textContent@@}}</div>
            {{column_planLabel}}

            {{column_planName data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.title@@@"}}
                <div class="pricing-plan-name">{{body||@@datalist.simpleCardTemplate.title@@}}</div>
            {{column_planName}}

            {{column_planSubtitle data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                <div class="pricing-plan-subtitle">{{body||@@datalist.simpleCardTemplate.textContent@@}}</div>
            {{column_planSubtitle}}

            <!-- Price -->
            <div class="pricing-price-row">
                {{column_price data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                    <div class="pricing-price-amount">{{body||"RM0.00"}}</div>
                {{column_price}}
                {{column_billingCycle data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                    <div class="pricing-price-period">{{body||" / mo"}}</div>
                {{column_billingCycle}}
            </div>

            {{column_priceNote data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                <div class="pricing-price-note">{{body||"Money-back guarantee"}}</div>
            {{column_priceNote}}

            <!-- Duration selector (optional) -->
            <div class="pricing-duration">
                {{column_durationSelector data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                    {{body}}
                {{column_durationSelector}}
            </div>

            <!-- CTA button: DataList row actions as primary \"Order Now\" style button -->
            <div class="pricing-cta">
                {{rowActions data-cbuilder-droparea-msg="@@datalist.simpleListTemplate.rowActions@@@"}}
                    <div class="rowActions" data-cbuilder-sort-horizontal>{{rowAction}}</div>
                {{rowActions}}
            </div>

            <!-- Features list: single builder drop area that can hold any number of fields -->
            <ul class="pricing-features" data-cbuilder-sort-horizontal data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@">
                {{columns}}
                    {{column}}
                        <li class="pricing-feature-item">
                            <i class="fa fa-check"></i>
                            <span class="pricing-feature-value">{{body}}</span>
                        </li>
                    {{column}}
                {{columns}}
            </ul>

            <!-- Footer link (e.g., "View Full Spec/Restriction") -->
            {{column_footerLink data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@@"}}
                <div class="pricing-footer-link">
                    {{body||"<a href='#'>View Full Spec/Restriction</a>"}}
                </div>
            {{column_footerLink}}
        </div>
    {{rows}}
</div>

<#-- Conditional coloring script: extracts condition column value from row data and compares -->
<script>
    (function() {
        var listDiv = document.getElementById("dataList_{{list.id}}");
        if (listDiv === null) {
            return;
        }


        // Values from plugin properties - access directly from element.properties (like original plugin)
        <#assign conditionGridRaw = element.properties.pricingCardConditionGrid!"" />
        <#assign otherColorProp = element.properties.pricingCardAllOtherCardsColor!allOtherCardsColor!"#dbeafe" />


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
        <#elseif conditionGridRaw?is_string && conditionGridRaw != "" && conditionGridRaw != "[]">
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
                // Error parsing grid JSON - silently continue with empty conditions
            }
        </#if>

        var defaultColor = '${otherColorProp?js_string}' || '#dbeafe';

        // Helper function to extract column value from card
        function extractColumnValue(card, columnId) {
            if (!columnId || !columnId.trim()) {
                return '';
            }
            
            columnId = columnId.trim();
            var val = '';
            var allElements = card.querySelectorAll('*');
            
            // Method 1: Look for element with ID containing columnId (Joget pattern: ph_column_{id} or column_{id})
            var idPatterns = ['ph_column_' + columnId, 'column_' + columnId, columnId];
            for (var p = 0; p < idPatterns.length; p++) {
                var el = card.querySelector('#' + idPatterns[p]);
                if (el) {
                    val = el.textContent || el.innerText || '';
                    if (val) return val.trim();
                }
            }
            
            // Method 2: Joget renders columns with class pattern: column_{columnId}
            var columnClass = 'column_' + columnId;
            var columnEl = card.querySelector('.' + columnClass);
            if (columnEl) {
                val = columnEl.textContent || columnEl.innerText || '';
                if (val) return val.trim();
            }
            
            // Method 3: Check for class containing the column ID (case-insensitive)
            for (var i = 0; i < allElements.length; i++) {
                var el = allElements[i];
                var className = (el.className || '').toString();
                if (className.indexOf('column_' + columnId) !== -1 ||
                    className.indexOf('column_' + columnId.toLowerCase()) !== -1 ||
                    className.indexOf('column_' + columnId.toUpperCase()) !== -1 ||
                    className.indexOf('ph_column_' + columnId) !== -1 ||
                    className.indexOf('ph_column_' + columnId.toLowerCase()) !== -1) {
                    val = el.textContent || el.innerText || '';
                    if (val) return val.trim();
                }
            }
            
            // Method 4: Look for data-column attribute
            var dataColumnEl = card.querySelector('[data-column="' + columnId + '"]');
            if (dataColumnEl) {
                val = dataColumnEl.textContent || dataColumnEl.innerText || '';
                if (val) return val.trim();
            }
            
            // Method 5: Search all elements for data attributes with column ID (case-insensitive)
            for (var i = 0; i < allElements.length; i++) {
                var el = allElements[i];
                var colId = el.getAttribute('data-column-id') || 
                           el.getAttribute('data-column') ||
                           el.getAttribute('data-field') || 
                           el.getAttribute('data-name') || '';
                if (colId && colId.toLowerCase() === columnId.toLowerCase()) {
                    val = el.textContent || el.innerText || '';
                    if (val) return val.trim();
                }
            }
            
            // Method 6: Check if columnId appears in any element's ID or class (partial match)
            for (var i = 0; i < allElements.length; i++) {
                var el = allElements[i];
                var elId = (el.id || '').toLowerCase();
                var elClass = (el.className || '').toString().toLowerCase();
                if ((elId && (elId.indexOf(columnId.toLowerCase()) !== -1 || elId.endsWith('_' + columnId.toLowerCase()))) ||
                    (elClass && elClass.indexOf(columnId.toLowerCase()) !== -1)) {
                    val = el.textContent || el.innerText || '';
                    if (val && val.trim() && val.trim().toLowerCase() !== columnId.toLowerCase()) {
                        return val.trim();
                    }
                }
            }
            
            return '';
        }

        var cards = listDiv.querySelectorAll('.pricing-card');

        cards.forEach(function(card, index) {
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

                // Extract value from card for this condition's column
                var cardValue = extractColumnValue(card, conditionColumnId);

                // Exact, case-sensitive match
                if (cardValue === conditionValue) {
                    matched = true;
                    matchedColor = cardColor || defaultColor;
                    break; // Use first match
                }
            }

            // Apply the matched color or default
            if (matched && matchedColor) {
                card.style.background = matchedColor;
            } else {
                card.style.background = defaultColor;
            }
        });
    })();
</script>


