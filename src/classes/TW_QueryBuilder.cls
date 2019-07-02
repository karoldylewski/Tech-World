
public with sharing class TW_QueryBuilder {
    private String outputQuery;

    public TW_QueryBuilder() {
        outputQuery = 'SELECT  FROM';
    }

    private String getSearchFormValue(String input) {
        String output;
        if (input != null) {
            output = input + '%';
        } else {
            output = '%';
        }
        return output;
    }

    private void insertField(String field) {
        String selectPart = outputQuery.substring(0, 7);
        String restOfQuery = outputQuery.substring(7);
        outputQuery = selectPart + ',' + field + ' ' + restOfQuery;
    }

    public TW_QueryBuilder addField(String field) {
        insertField(field);
        return this;
    }

    public TW_QueryBuilder addSourceObject(String obj) {
        outputQuery += ' ' + obj + ' WHERE ';
        return this;
    }

    public TW_QueryBuilder addCondition(String field, Object condition) {
        if (condition == '' || condition == null){
            insertField(field);
            return this;
        }
        if (condition instanceof String) {
            String convertedValue = getSearchFormValue((String) condition);
            outputQuery += field + ' LIKE \'' + convertedValue + '\' AND ';
            insertField(field);
        }
          else if (condition instanceof Integer && condition == null || condition==0){
            insertField(field);
        }
        return this;
    }

    public TW_QueryBuilder addOrder(String column, String orderDirection) {
        outputQuery = outputQuery.substring(0, outputQuery.length() - 5);
        outputQuery += ' ORDER BY ' + column + ' ' + orderDirection;
        return this;
    }

    public String getQuery() {
        String selectPart = outputQuery.substring(0, 7);
        String restOfQuery = outputQuery.substring(8);
        outputQuery = selectPart + restOfQuery;
        return outputQuery;
    }
}