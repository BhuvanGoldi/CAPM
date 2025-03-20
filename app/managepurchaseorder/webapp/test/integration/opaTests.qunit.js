sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'cap2/managepurchaseorder/test/integration/FirstJourney',
		'cap2/managepurchaseorder/test/integration/pages/POsList',
		'cap2/managepurchaseorder/test/integration/pages/POsObjectPage',
		'cap2/managepurchaseorder/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('cap2/managepurchaseorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);