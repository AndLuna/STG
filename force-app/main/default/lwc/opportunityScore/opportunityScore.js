import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getOppScore from '@salesforce/apex/OpportunityScoreController.getOppScore';

const FIELDS_TO_RETRIEVE = [
    'Opportunity.OppSource_SomadePontos__c',
    'Opportunity.PKL_Satisfacao__c'
];

export default class OpportunityScore extends LightningElement {
    @api recordId;

   // satisfactionLevel = ''; 
    
    oppScore = 0;
    satisfacaoPontos = 0;
    satisfacaoLabel = '';
    satisfacaoPontuacaoMap = {
        '1': 20,
        '2': 40,
        '3': 60,
        '4': 80,
        '5': 100
    };

    // Improvement Section
    improvementButtonLabel = 'Show';
    isImprovementVisible = false;

    // Wire methods
    @wire(getOppScore, { opportunityId: '$recordId' })
    wiredOpportunity({ error, data }) {
        if (data) {
            this.oppScore = data.OppSource_SomadePontos__c;
        } else if (error) {
            console.error('Error retrieving lead score', error);
        }
    }
    

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS_TO_RETRIEVE })
    wiredRecord({ error, data }) {
        if (data) {
        
            this.oppScore = getFieldValue(data, 'Opportunity.OppSource_SomadePontos__c');
            this.satisfacaoPontos = ['1', '2', '3', '4', '5'].includes(getFieldValue(data, 'Opportunity.PKL_Satisfacao__c'));

            const decisorValue = getFieldValue(data, 'Opportunity.PKL_Satisfacao__c');
            this.satisfacaoPontos = this.satisfacaoPontuacaoMap[decisorValue];
            this.satisfacaoLabel = decisorValue;

        } else if (error) {
            console.error('Error retrieving record', error);
        }
    }

    // Handle Improvement Click
    handleImprovementClick() {
        this.isImprovementVisible = !this.isImprovementVisible;
        this.improvementButtonLabel = this.isImprovementVisible ? 'Hide' : 'Show';
    }

    // Calculated properties
    get scoreColorClass() {
        if (this.oppScore >= 60) {
            return 'green-circle';
        } else if (this.oppScore >= 20 && this.oppScore < 60) {
            return 'yellow-circle';
        } else {
            return 'red-circle';
        }
    }

}