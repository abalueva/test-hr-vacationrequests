import {LightningElement, track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NoManager from '@salesforce/apex/newRequestController.NoManager';

export default class NewRequest extends LightningElement {
    @track RequestType;
    @track StartDate;
    @track EndDate;
    @track check;
    @track isModalOpen = false;
    @wire(NoManager) manager;

    openModal() {
        if (this.manager.data == true) {
            this.showNoManagerNotification();
        } else {
            this.isModalOpen = true;
            this.check = this.checkSubmitDetails();
        }
    }

    closeModal() {
        this.isModalOpen = false;
    }

    showNoManagerNotification() {
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

    checkRequestType(event) {
        this.RequestType = event.target.value;
        this.check = this.checkSubmitDetails();
    }

    checkStartDate(event) {
        let selected = new Date(event.target.value);
        let today = new Date();
        if (selected.toISOString().slice(0,10) < today.toISOString().slice(0,10)) {
            this.StartDate = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Enter valid date',
                variant: 'error',
                message: `Date should be ${today.toDateString()} or later`,
            }));
        }
        else
            this.StartDate = selected.toISOString().slice(0,10);
        this.check = this.checkSubmitDetails();
    }

    checkEndDate(event) {
        let selected = new Date(event.target.value);
        let today = new Date();
        if (selected.toISOString().slice(0,10) < today.toISOString().slice(0,10)) {
            this.EndDate = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Enter valid date',
                variant: 'error',
                message: `Date should be ${today.toDateString()} or later`,
            }));
        }
        else
            this.EndDate = selected.toISOString().slice(0,10);
        this.check = this.checkSubmitDetails();
    }

    checkSubmitDetails() {
        if (this.StartDate >= this.EndDate) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Enter valid date',
                variant: 'error',
                message: `End Date should be later than Start Date`,
            }));
            return true;
        }
        if (this.StartDate && this.EndDate && this.RequestType)
            return false;
        return true;
    }
}