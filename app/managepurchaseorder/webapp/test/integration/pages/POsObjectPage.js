sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'cap2.managepurchaseorder',
            componentId: 'POsObjectPage',
            contextPath: '/POs'
        },
        CustomPageDefinitions
    );
});