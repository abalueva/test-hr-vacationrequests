import {LightningElement, track} from 'lwc';
import getRequestList from '@salesforce/apex/RequestsController.getRequestList';

export default class AllRequests extends LightningElement {
    @track requests;
    @track error;

    handleLoad() {
        getRequestList()
            .then(result => {
                this.requests = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
}