import {LightningElement, wire} from 'lwc';
import getRequestList from '@salesforce/apex/requestListController.getRequestList';
import getOnlyMyList from '@salesforce/apex/requestListController.getOnlyMyList';

export default class ShowOnlyMy extends LightningElement {
    @wire (getRequestList) allRequests;
    @wire (getOnlyMyList) myRequests;

    handleChange(event) {
        if (event.target.checked == true)
            this.dispatchEvent(new CustomEvent('selected', {detail: this.myRequests}));
        else
            this.dispatchEvent(new CustomEvent('selected', {detail: this.allRequests}));
    }
}