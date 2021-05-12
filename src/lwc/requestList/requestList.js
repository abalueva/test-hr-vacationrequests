import {LightningElement, track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getRequestList from '@salesforce/apex/vrController.getRequestList';
import getOnlyMyList from '@salesforce/apex/vrController.getOnlyMyList';
import NoManager from '@salesforce/apex/vrController.NoManager';

export default class RequestList extends LightningElement {
    @wire (getRequestList) requests;
    @wire (getRequestList) allRequests;
    @wire (getOnlyMyList) myRequests;
    @wire (NoManager) manager;
    @track showOnlyMy = false;
    @track isModalOpen = false;

    handleChange(event) {
        this.showOnlyMy = event.target.checked;
        if (this.showOnlyMy == true) {
            this.requests = this.myRequests;
        }
        else {
            this.requests = this.allRequests;
        }
    }

    openModal() {
        if (this.manager.data == null){
            this.showNotification();
        }
        else {
            this.isModalOpen = true;
        }
    }
    closeModal() {
        this.isModalOpen = false;
    }
    showNotification() {
        const evt = new ShowToastEvent({
            title: 'No Manager Found',
            message: "Manager isn't specified",
            variant: 'warning',
        });
        this.dispatchEvent(evt);
    }
    submitDetails() {
        window.location.reload();
    }
    get startDate() {
        var today = new Date();
        return today.toISOString().slice(0,10);
    }
}