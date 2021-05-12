import {LightningElement, track, wire} from 'lwc';
import getRequestList from '@salesforce/apex/requestListController.getRequestList';

export default class RequestList extends LightningElement {
    @wire (getRequestList) requests;

    handleChange(event) {
        this.requests = event.detail;
    }
}