import { LightningElement, api, wire } from 'lwc';
import vrRemove from '@salesforce/apex/vrController.vrRemove';
import vrSubmit from '@salesforce/apex/vrController.vrSubmit';
import vrApprove from '@salesforce/apex/vrController.vrApprove';
import getUserId from '@salesforce/apex/vrController.getUserId';

export default class RequestListItem extends LightningElement {
    @api it;
    @wire (getUserId) userId;

    get showRemove() {
        if (this.it.Status__c == 'New' && this.it.CreatedById == this.userId.data)
            return true;
        else
            return false;
    }
    get showSubmit() {
        if (this.it.Status__c == 'New' && this.it.CreatedById == this.userId.data)
            return true;
        else
            return false;
    }
    get showApprove() {
        if (this.it.Status__c == 'Submitted' && this.it.Manager__r.Id == this.userId.data)
            return true;
        else
            return false;
    }
    test = 1;

    buttonRemove(event) {
        vrRemove({vrName : this.it.Name});
        window.location.reload();
    }
    buttonSubmit(event) {
        vrSubmit({vrName : this.it.Name});
        window.location.reload();
    }
    buttonApprove(event) {
        vrApprove({vrName : this.it.Name});
        window.location.reload();
    }
}