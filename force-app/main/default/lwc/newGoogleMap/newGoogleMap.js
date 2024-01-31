import { LightningElement, api, wire, track } from 'lwc';
import{getRecord} from "lightning/uiRecordApi";

const fieldsArray = [
    "Account.Name",
    "Account.BillingStreet",
    "Account.BillingCity",
    "Account.BillingState",
    "Account.BillingPostalCode",
    "Account.BillingCountry",
];

export default class NewGoogleMap extends LightningElement {

     @api recordId;
     @track mapMarkers = [];

     accountName;
     billingStreet;
     billingCity;
     billingState;
     billingPostalCode;
     billingCountry;


     @wire(getRecord, {recordId:"$recordId", fields: fieldsArray})
     wiredRecord({error, data}){
        if(data){
            JSON.stringify("data from account by wire::", data);
            this.billingStreet = data.fields.BillingStreet.value;
            this.billingCity = data.fields.BillingCity.value;
            this.billingState = data.fields.BillingState.value;
            this.billingPostalCode = data.fields.BillingPostalCode.value;
            this.billingCountry = data.fields.BillingCountry.value;
            this.accountName = data.fields.Name.value;

            const marker = {
                location: {
                    Street: this.billingStreet ? this.billingStreet : "",
                    City: this.billingCity ? this.billingCity : "",
                    State: this.billingState ? this.billingState : "",
                    PostalCode: this.billingPostalCode ? this.billingPostalCode : "",
                    Country: this.billingCountry ? this.billingCountry : ""
                },
                tittle: this.accountName ? this.accountName : ""
            };

            this.mapMarkers = [marker];
            this.error = undefined;
        }else if(error){
            this.mapMarkers = undefined;
            this.error = error;
        }
     }

}