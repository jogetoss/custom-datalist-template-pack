package org.joget.marketplace;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joget.apps.app.service.AppUtil;
import org.joget.apps.datalist.model.DataListColumn;
import org.joget.apps.datalist.model.DataListTemplate;
import org.joget.workflow.util.WorkflowUtil;

public class CustomDataListTemplate extends DataListTemplate {
    
    private final static String MESSAGE_PATH = "messages/CustomDataListTemplate";

    /**
     * ThreadLocal flag to break the recursion that occurs when FreeMarker calls
     * getDatalist().getColumns(), which internally calls getTemplate() again.
     * On the recursive call we return an empty list so the inner render completes
     * (DataList only needs {{column}} markers from that inner render), and the
     * outer call gets the real sortable column IDs.
     */
    private static final ThreadLocal<Boolean> COMPUTING_SORTABLE_COLUMNS = new ThreadLocal<>();

    /**
     * Returns the list of column IDs (e.g. "column_1") whose sortable flag is true.
     * Safe to call from FreeMarker via {@code element.sortableColumnIds}.
     */
    public List<String> getSortableColumnIds() {
        if (Boolean.TRUE.equals(COMPUTING_SORTABLE_COLUMNS.get())) {
            return Collections.emptyList();
        }
        COMPUTING_SORTABLE_COLUMNS.set(true);
        try {
            DataListColumn[] columns = getDatalist().getColumns();
            List<String> result = new ArrayList<>();
            if (columns != null) {
                for (DataListColumn col : columns) {
                    if (col.isSortable()) {
                        result.add(col.getPropertyString("id"));
                    }
                }
            }
            return result;
        } finally {
            COMPUTING_SORTABLE_COLUMNS.remove();
        }
    }
    
    @Override
    public String getName() {
        return "CustomDataListTemplate";
    }

    @Override
    public String getVersion() {
        return "9.0.1";
    }

    @Override
    public String getDescription() {
        return "Custom DataList Template with multiple template options";
    }
    
    @Override
    public String getLabel() {
        return "List - Custom DataList Template Pack";
    }

    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getPropertyOptions() {
        // Load properties from single file
        return AppUtil.readPluginResource(getClass().getName(), "/properties/customDataListTemplate.json", null, true, MESSAGE_PATH);
    }
    
    /**
     * Helper method to get property with default value
     * Returns default if property is null or empty
     */
    private String getPropertyWithDefault(String propertyName, String defaultValue) {
        String value = getPropertyString(propertyName);
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        return value.trim();
    }
    
    @Override
    public String getTemplate() {
        // Get the selected template type
        String templateType = getPropertyString("templateType");
        if (templateType == null || templateType.isEmpty()) {
            templateType = "template1"; // default to template1
        }
        
        // Map template types to actual template files
        String templateFileName;
        if ("template1".equals(templateType)) {
            templateFileName = "pricing_card_template.ftl";
        } else if ("template2".equals(templateType)) {
            templateFileName = "multi_columns_template.ftl";
        } else if ("template3".equals(templateType)) {
            templateFileName = "profile_grid_template.ftl";
        } else if ("template4".equals(templateType)) {
            templateFileName = "ribbon_row_template.ftl";
        } else if ("template5".equals(templateType)) {
            templateFileName = "expand_row_template.ftl";
        } else if ("template6".equals(templateType)) {
            templateFileName = "sticky_actions_protected_rows_template.ftl";
        } else {
            // Default mapping for other templates
            templateFileName = templateType + ".ftl";
        }
        
        // Determine which template file to load
        String templatePath = "/templates/" + templateFileName;
        
        // Prepare data for the template
        Map<String, String> data = new HashMap<>();
        data.put("templateType", templateType);
        
        // Common properties for multiple templates
        String actionsStyle = getPropertyString("actionsStyle");
        String separator = getPropertyString("separator");
        
        // Template 1: Pricing Card
        if ("template1".equals(templateType)) {
            String cardsPerRow = getPropertyString("cardsPerRow");
            if (cardsPerRow == null || cardsPerRow.isEmpty()) {
                cardsPerRow = "4"; // default to 4 cards per row
            }
            String conditionColumnId = getPropertyString("conditionColumnId");
            
            // Don't pass conditionGrid through data map - let template access it via element.properties
            // This prevents duplication issues
            data.put("cardsPerRow", cardsPerRow);
            data.put("actionsStyle", actionsStyle != null ? actionsStyle : "");
            data.put("conditionColumnId", conditionColumnId != null ? conditionColumnId : "");
        }
        // Template 2: Multi Columns
        else if ("template2".equals(templateType)) {
            data.put("actionsStyle", actionsStyle != null ? actionsStyle : "");
            data.put("separator", separator != null ? separator : "-");
        }
        // Template 3: Profile Grid
        else if ("template3".equals(templateType)) {
            data.put("actionsStyle", actionsStyle != null ? actionsStyle : "");
        }
        // Template 4: Ribbon Row
        else if ("template4".equals(templateType)) {
            // Don't pass conditionGrid through data map - let template access it via element.properties
            data.put("actionsStyle", actionsStyle != null ? actionsStyle : "");
            data.put("separator", separator != null ? separator : "-");
        }
        // Template 5: Expand Row
        else if ("template5".equals(templateType)) {
            // Get properties with defaults
            String expandIcon = getPropertyWithDefault("expandIcon", "fas fa-chevron-right");
            String collapseIcon = getPropertyWithDefault("collapseIcon", "fas fa-chevron-down");
            String layout = getPropertyWithDefault("layout", "horizontal");
            String expandableFieldsCount = getPropertyWithDefault("expandableFieldsCount", "5");
            
            // Validate and set default value for expandableFieldsCount
            int fieldsCount = 5; // default
            try {
                fieldsCount = Integer.parseInt(expandableFieldsCount);
                // Ensure it's between 1 and 10
                if (fieldsCount < 1) fieldsCount = 1;
                if (fieldsCount > 10) fieldsCount = 10;
            } catch (NumberFormatException e) {
                fieldsCount = 5; // fallback to default
            }
            
            data.put("expandIcon", expandIcon);
            data.put("collapseIcon", collapseIcon);
            data.put("layout", layout);
            data.put("expandableFieldsCount", String.valueOf(fieldsCount));
            
            // Check if we're in design view for expand row template
            boolean isDesignView = false;
            try {
                // Use reflection to avoid compile-time dependency on HttpServletRequest
                java.lang.reflect.Method getRequestMethod = WorkflowUtil.class.getMethod("getHttpServletRequest");
                Object request = getRequestMethod.invoke(null);
                if(request != null) {
                    java.lang.reflect.Method getRequestURIMethod = request.getClass().getMethod("getRequestURI");
                    Object uriObj = getRequestURIMethod.invoke(request);
                    if(uriObj != null) {
                        String requestURI = uriObj.toString();
                        if(requestURI.endsWith("/getRenderingTemplate")) {
                            isDesignView = true;
                        }
                    }
                }
            } catch (Exception e) {
                // If we can't determine, default to false (normal view)
                isDesignView = false;
            }
            data.put("isDesignView", isDesignView ? "true" : "false");
            
            // Use design template if in design view
            if(isDesignView){
                templateFileName = "expand_row_template_design.ftl";
                templatePath = "/templates/" + templateFileName;
            }
        }
        // Template 6: Sticky Actions & Protected Rows (has its own design template)
        else if ("template6".equals(templateType)) {
            // Repeater (protectedRowsConditionGrid) is read by template via element.properties

            // Check if we're in design view for template 6
            boolean isDesignView = false;
            try {
                java.lang.reflect.Method getRequestMethod = WorkflowUtil.class.getMethod("getHttpServletRequest");
                Object request = getRequestMethod.invoke(null);
                if (request != null) {
                    java.lang.reflect.Method getRequestURIMethod = request.getClass().getMethod("getRequestURI");
                    Object uriObj = getRequestURIMethod.invoke(request);
                    if (uriObj != null && uriObj.toString().endsWith("/getRenderingTemplate")) {
                        isDesignView = true;
                    }
                }
            } catch (Exception e) {
                isDesignView = false;
            }

            if (isDesignView) {
                templateFileName = "sticky_actions_protected_rows_template_design.ftl";
                templatePath = "/templates/" + templateFileName;
            }
        }

        // Load and return the selected template
        return getTemplate(data, templatePath, null);
    }
    
}

