import { LightningElement, api, wire, track } from 'lwc';
import{getRecord} from "lightning/uiRecordApi";

const fieldsArray = [
    "Lead.LastName",
    "Lead.City",
    "Lead.State",
    "Lead.PostalCode",
    "Lead.Country",
    "Lead.Street"
];

export default class NewGoogleMap extends LightningElement {

     @api recordId;
     @track mapMarkers = [];

     leadLastName;
     street;
     city;
     state;
     postalCode;
     Country;


     @wire(getRecord, {recordId:"$recordId", fields: fieldsArray})
     wiredRecord({error, data}){
        if(data){
            JSON.stringify("data from lead by wire::", data);
            this.city = data.fields.City.value;
            this.state = data.fields.State.value;
            this.postalCode = data.fields.PostalCode.value;
            this.street = data.fields.Street.value;
            this.country = data.fields.Country.value;
            this.leadLastName = data.fields.LastName.value;

            const marker = {
                location: {
                    Street: this.street ? this.street : "",
                    City: this.city ? this.city : "",
                    State: this.state ? this.state : "",
                    PostalCode: this.postalCode ? this.postalCode : "",
                    Country: this.country ? this.country : ""
                },
                tittle: this.leadLastName ? this.leadLastName : ""
            };

            this.mapMarkers = [marker];
            this.error = undefined;
        }else if(error){
            this.mapMarkers = undefined;
            this.error = error;
        }
     }

}