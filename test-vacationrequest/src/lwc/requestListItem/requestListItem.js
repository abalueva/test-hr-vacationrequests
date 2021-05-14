import { LightningElement, api, wire } from 'lwc';
import showRemoveSubmit from '@salesforce/apex/requestListItemController.showRemoveSubmit';
import showApprove from '@salesforce/apex/requestListItemController.showApprove';
import vrRemove from '@salesforce/apex/requestListItemController.vrRemove';
import vrSubmit from '@salesforce/apex/requestListItemController.vrSubmit';
import vrApprove from '@salesforce/apex/requestListItemController.vrApprove';
import getColor from '@salesforce/apex/requestListItemController.getColor';

export default class RequestListItem extends LightningElement {
    @api it;
    @wire (getColor, {Status: '$it.Status__c'}) divColor;
    @wire (showRemoveSubmit, {vr: '$it'}) showRemoveSubmit;
    @wire (showApprove, {vr: '$it'}) showApprove;

    buttonRemove() {
        vrRemove({vrToRemove : this.it});
        window.location.reload();
    }
    buttonSubmit() {
        vrSubmit({vrToSubmit : this.it});
        window.location.reload();
    }
    buttonApprove() {
        vrApprove({vrToApprove : this.it});
        window.location.reload();
    }
}