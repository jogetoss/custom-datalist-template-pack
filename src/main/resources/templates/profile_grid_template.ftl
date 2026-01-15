<style>
    #dataList_{{list.id}} .list-group-item.data-row {
        border-radius: 8px;
        border: 1px solid #f5c778;
        margin-bottom: 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        padding: 0;
        background: #ffffff;
        position: relative;
    }

    #dataList_{{list.id}} .list-card-container {
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    #dataList_{{list.id}} .list-card-header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 16px;
    }

    #dataList_{{list.id}} .list-card-profile-section {
        display: flex;
        align-items: flex-start;
        gap: 16px;
        flex: 1;
    }

    #dataList_{{list.id}} .list-card-avatar {
        width: 64px;
        height: 64px;
        border-radius: 50%;
        overflow: hidden;
        background: #1e3a8a;
        color: white;
        font-weight: 600;
        font-size: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    #dataList_{{list.id}} .list-card-avatar .avatar-initials {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
    }

    #dataList_{{list.id}} .list-card-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    #dataList_{{list.id}} .list-card-info {
        flex: 1;
    }

    #dataList_{{list.id}} .list-card-name {
        font-size: 24px;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 6px;
        line-height: 1.2;
    }

    #dataList_{{list.id}} .list-card-email {
        font-size: 14px;
        color: #6b7280;
        margin-bottom: 4px;
    }

    #dataList_{{list.id}} .list-card-userid {
        font-size: 13px;
        color: #9ca3af;
    }

    #dataList_{{list.id}} .list-card-badges {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 8px;
        flex-shrink: 0;
    }

    #dataList_{{list.id}} .list-card-badge {
        padding: 6px 12px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
        text-transform: lowercase;
        white-space: nowrap;
        display: inline-block;
    }

    #dataList_{{list.id}} .list-card-badge.role {
        background: #dbeafe;
        color: #1e40af;
    }

    #dataList_{{list.id}} .list-card-badge.status {
        background: #d1fae5;
        color: #065f46;
    }

    #dataList_{{list.id}} .list-card-data-grid {
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        gap: 20px 24px;
        margin-top: 8px;
        align-items: flex-start;
    }

    #dataList_{{list.id}} .list-card-data-grid > * {
        flex: 1 1 0;
        min-width: 150px;
        display: inline-block;
    }

    /* Force horizontal layout in builder */
    #dataList_{{list.id}} .list-card-data-grid[data-cbuilder-sort-horizontal] > *,
    #dataList_{{list.id}} .list-card-data-grid .cbuilder-droparea,
    #dataList_{{list.id}} .list-card-data-grid .cbuilder-droparea > *,
    #dataList_{{list.id}} .list-card-data-grid[data-cbuilder-sort-horizontal] {
        display: flex !important;
        flex-direction: row !important;
        flex-wrap: wrap !important;
    }
    
    #dataList_{{list.id}} .list-card-data-grid[data-cbuilder-sort-horizontal] > * > * {
        display: inline-block !important;
        vertical-align: top;
    }

    #dataList_{{list.id}} .list-card-data-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
        min-width: 0;
    }

    #dataList_{{list.id}} .list-card-data-label {
        font-size: 12px;
        color: #9ca3af;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    #dataList_{{list.id}} .list-card-data-value {
        font-size: 14px;
        color: #1f2937;
        font-weight: 600;
        min-height: 20px;
    }

    #dataList_{{list.id}} .list-card-data-value:empty {
        min-height: 20px;
    }

    #dataList_{{list.id}} .list-card-footer {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding-top: 16px;
        border-top: 1px solid #f3f4f6;
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
        gap: 12px;
    }

    #dataList_{{list.id}} .list-card-actions a {
        background-color: #007bff;
        color: #ffffff;
        font-size: 14px;
        font-weight: 500;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 4px;
        border: none;
        transition: background-color 0.2s;
        display: inline-block;
        white-space: nowrap;
    }

    #dataList_{{list.id}} .list-card-actions a:hover {
        background-color: #0056b3;
        color: #ffffff;
    }

    .rowActions.d-flex {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .rowActions.d-flex > a {
        background-color: #007bff;
        color: #ffffff;
        font-size: 14px;
        font-weight: 500;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 4px;
        border: none;
        transition: background-color 0.2s;
        display: inline-block;
        white-space: nowrap;
    }

    .rowActions.d-flex > a:hover {
        background-color: #0056b3;
        color: #ffffff;
    }

    @media (max-width: 767.98px) {
        #dataList_{{list.id}} .list-card-header {
            flex-direction: column;
        }

        #dataList_{{list.id}} .list-card-badges {
            flex-direction: row;
            align-items: center;
            width: 100%;
        }

        #dataList_{{list.id}} .list-card-data-grid {
            flex-direction: column;
            gap: 16px;
        }

        #dataList_{{list.id}} .list-card-footer {
            flex-direction: column;
            align-items: flex-start;
            gap: 12px;
        }
    }
</style>

<div class="list-group p-0 border-0">
    {{rows data-cbuilder-highlight="@@datalist.simpleListTemplate.list@@" data-cbuilder-style="[{'prefix' : 'list', 'class' : '.list-group-item', 'label' : '@@datalist.simpleListTemplate.list@@'}]"}}
        <div class="data-row list-group-item ${actionsStyle!""}" style="position:relative">
            <div class="list-card-container">
                <!-- Header Section: Profile Info and Badges -->
                <div class="list-card-header">
                    <div class="list-card-profile-section">
                        {{selector}}
                            <div class="me-2">{{body}}</div>
                        {{selector}}

                        {{column_image data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.image@@"}}
                            <div class="list-card-avatar" data-name-field>
                                {{body||<span class="avatar-initials">@@datalist.simpleCardTemplate.image@@</span>}}
                            </div>
                        {{column_image}}

                        <div class="list-card-info">
                            {{column_title data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.title@@"}}
                                <div class="list-card-name">{{body||@@datalist.simpleCardTemplate.title@@}}</div>
                            {{column_title}}

                            {{column_email data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <div class="list-card-email">{{body||@@datalist.simpleCardTemplate.textContent@@}}</div>
                            {{column_email}}

                            {{column_userid data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                                <div class="list-card-userid">{{body||@@datalist.simpleCardTemplate.textContent@@}}</div>
                            {{column_userid}}
                        </div>
                    </div>

                    <div class="list-card-badges" data-cbuilder-sort-horizontal>
                        {{column_role data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                            <span class="list-card-badge role">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                        {{column_role}}
                        {{column_status data-cbuilder-droparea-msg="@@datalist.simpleCardTemplate.textContent@@"}}
                            <span class="list-card-badge status">{{body||@@datalist.simpleCardTemplate.textContent@@}}</span>
                        {{column_status}}
                    </div>
                </div>

                <!-- Data Grid Section: Company, Location, Last Login, Join Date -->
                <div class="list-card-data-grid" data-cbuilder-sort-horizontal style="display: flex; flex-direction: row; flex-wrap: wrap; gap: 20px 24px; align-items: flex-start;">
                    {{columns}}
                        {{column}}
                            <span style="display: inline-block; vertical-align: top; flex: 1 1 0; min-width: 150px;">
                                <div class="list-card-data-item" style="display: flex; flex-direction: column; gap: 4px; width: 100%;">
                                    <div class="list-card-data-label">{{label||@@datalist.simpleCardTemplate.textContent@@}}</div>
                                    <div class="list-card-data-value">{{body||<span style="color: #d1d5db;">—</span>}}</div>
                                </div>
                            </span>
                        {{column}}
                    {{columns}}
                </div>

                <!-- Footer Section: Actions -->
                <div class="list-card-footer">
                    <div class="list-card-actions">
                        <#assign actionsStyleValue = actionsStyle!"" />
                        <#if actionsStyleValue == 'normalActions' || actionsStyleValue == 'swipeActions'>
                            {{rowActions}}
                                <div class="rowActions d-flex" data-cbuilder-sort-horizontal>{{rowAction}}</div>
                            {{rowActions}}
                        <#elseif actionsStyleValue == 'bottomActions'>
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

            <#if actionsStyleValue == 'swipeActions'>
                {{rowActions}}
                    <div class="px-3 rowActionsContainer">
                        <div class="rowActions" data-cbuilder-sort-horizontal>{{rowAction}}</div>
                    </div>
                {{rowActions}}
            </#if>
        </div>
    {{rows}} 
    <script>
        $(function(){
            var listDiv = document.getElementById("dataList_{{list.id}}");

            function applyDataGridAlignment() {
                if (listDiv === null) {
                    return;
                }

                var isNarrow = $(window).width() < 768;

                $(listDiv).find('.list-card-data-grid').each(function(){
                    var $grid = $(this);
                    var $items = $grid.children();
                    var isBuilder = $grid.find('.cbuilder-droparea').length > 0;

                    if (!isBuilder && !isNarrow) {
                        $grid.css({
                            'justify-content': 'flex-start',
                            'align-content': 'flex-start'
                        });
                        $items.css({
                            'flex': '0 0 220px',
                            'width': '220px',
                            'min-width': '180px',
                            'max-width': '260px',
                            'display': 'inline-block'
                        });
                    } else {
                        $grid.css({
                            'justify-content': '',
                            'align-content': ''
                        });
                        $items.css({
                            'flex': '',
                            'width': '',
                            'min-width': '',
                            'max-width': '',
                            'display': ''
                        });
                    }
                });
            }

            applyDataGridAlignment();

            $(window).on('resize.dataList_{{list.id}}_grid', function(){
                applyDataGridAlignment();
            });

            // Hide icon when span is empty (replaces the FreeMarker conditional)
            if (listDiv !== null) {
                $(listDiv).find('.list-card-phone').each(function(){
                    $(this).find('span').each(function(){
                        if ($(this).text().trim() === '') {
                            $(this).prev('i').hide();
                            $(this).hide();
                        }
                    });
                });
            }

            // Generate initials from name for avatars
            if (listDiv !== null) {
                $(listDiv).find('.list-card-avatar[data-name-field]').each(function(){
                    var $avatar = $(this);
                    var $nameElement = $avatar.closest('.list-card-profile-section').find('.list-card-name');
                    var name = $nameElement.text().trim();
                    
                    // Only generate initials if avatar doesn't have an image
                    if ($avatar.find('img').length === 0 && $avatar.find('.avatar-initials').text().trim() === '@@datalist.simpleCardTemplate.image@@') {
                        var initials = '';
                        if (name) {
                            var words = name.split(/\s+/);
                            if (words.length >= 2) {
                                initials = (words[0].charAt(0) + words[words.length - 1].charAt(0)).toUpperCase();
                            } else if (words.length === 1) {
                                initials = words[0].substring(0, 2).toUpperCase();
                            }
                            $avatar.find('.avatar-initials').text(initials);
                        }
                    }
                });
            }

            <#assign actionsStyleValue = actionsStyle!"" />
            <#if actionsStyleValue == 'swipeActions'>
            var pointerListener = null;

            if (listDiv !== null) {
                function onSwipeLeft (event) {
                    var thisObj = this;
                    if (!$(thisObj).hasClass("swiped") && $(thisObj).find('.rowActionsContainer').css("position") === "absolute") {
                        $(thisObj).addClass("swiped");
                        $(thisObj).find("> div:not(.rowActionsContainer)").css('transform', 'translateX(-'+$(thisObj).find('.rowActionsContainer').width()+'px)');

                        //when on click/touch of non actions area, hide back the actions
                        $(thisObj).on("click.swiped", "*", function(){
                            if ($(this).closest(".rowActions").length === 0) {
                                $(thisObj).find("> div:not(.rowActionsContainer)").css('transform', 'translateX(0)');
                                $(thisObj).removeClass("swiped");
                                $(thisObj).off("click.swiped"); 
                            }
                        });
                    }
                }

                var resize = function() {
                    if ($(window).width() < 768) {
                        pointerListener = new PointerListener(listDiv, {
                            supportedGestures : [Pan]
                        });

                        //bind swipeleft event to each data row
                        $(listDiv).find(".data-row").each(function(){
                            if ($(this).find('.rowActions a').length > 0) {
                                this.addEventListener('swipeleft', onSwipeLeft);
                            }
                        });
                    } else {
                        //unbind swipeleft event to each data row
                        $(listDiv).find(".data-row").each(function(){
                            if ($(this).find('.rowActions a').length > 0) {
                                this.removeEventListener('swipeleft', onSwipeLeft);
                            }
                        });

                        if (pointerListener) {
                            pointerListener.destroy();
                        }
                    }
                };    
                $(window).off("resize.dataList_{{list.id}}")
                    .on("resize.dataList_{{list.id}}", function(){
                    resize();
                });
                resize();
            }
            </#if>
        });
    </script>
</div>   




