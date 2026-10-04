import { LightningElement, wire, track } from 'lwc';
import getOpenServiceRequests from '@salesforce/apex/ServiceRequestController.getOpenServiceRequests';
import getRequestMetrics from '@salesforce/apex/ServiceRequestController.getRequestMetrics';

const COLUMNS = [
    { label: 'Request Number', fieldName: 'Name', type: 'text' },
    { label: 'Category', fieldName: 'Category__c', type: 'text' },
    { label: 'Status', fieldName: 'Status__c', type: 'text' },
    { label: 'Priority', fieldName: 'Priority__c', type: 'text' },
    { label: 'Estimated Cost', fieldName: 'Estimated_Cost__c', type: 'currency' },
    { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' }
];

export default class SpsmpServiceDashboard extends LightningElement {
    @track requests = [];
    columns = COLUMNS;

    totalRequests = 0;
    newRequests = 0;
    inProgressRequests = 0;
    resolvedRequests = 0;

    @wire(getRequestMetrics)
    wiredMetrics({ error, data }) {
        if (data) {
            this.totalRequests = data.Total || 0;
            this.newRequests = data.New || 0;
            this.inProgressRequests = data.InProgress || 0;
            this.resolvedRequests = data.Resolved || 0;
        } else if (error) {
            console.error('Error fetching metrics:', error);
        }
    }

    @wire(getOpenServiceRequests)
    wiredRequests({ error, data }) {
        if (data) {
            this.requests = data;
        } else if (error) {
            console.error('Error fetching service requests:', error);
        }
    }
}