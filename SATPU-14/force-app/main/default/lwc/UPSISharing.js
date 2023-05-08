// Generated JS File for LWC Component

import { LightningElement, track, api } from 'lwc';

export default class ShareUPSI extends LightningElement {
    
    @track dateOfSharingUPSI;
    @track personsSharedWith;
    @track natureOfUPSI;
    @track detailsOfUPSI;
    @track legitimatePurposeOfSharingUPSI;
    @track attachment;
    @track supplierOfInformationName;
    @track supplierOfInformationPAN;
    @track receiverOfInformationName;
    @track receiverOfInformationPAN;
    @track auditTrail;
    @track notes;
    
    submitUPSI(){
        // Validate required fields
        if(!this.dateOfSharingUPSI || !this.personsSharedWith || !this.natureOfUPSI || !this.detailsOfUPSI || !this.legitimatePurposeOfSharingUPSI){
            alert('Please fill all the required fields');
            return;
        }
        
        // Submit UPSI form
        // Send emails to designated persons
        // Send email notification to Compliance Officer
        alert('UPSI form submitted successfully!');
    }
    
    resetUPSI(){
        // Reset UPSI form
        this.dateOfSharingUPSI = null;
        this.personsSharedWith = null;
        this.natureOfUPSI = null;
        this.detailsOfUPSI = null;
        this.legitimatePurposeOfSharingUPSI = null;
        this.attachment = null;
        this.supplierOfInformationName = null;
        this.supplierOfInformationPAN = null;
        this.receiverOfInformationName = null;
        this.receiverOfInformationPAN = null;
        this.auditTrail = null;
        this.notes = null;
    }
    
    handleDateTimeChange(event){
        this.dateOfSharingUPSI = event.detail.value;
    }
    
    handlePersonChange(event){
        this.personsSharedWith = event.detail.value;
    }
    
    handleNatureChange(event){
        this.natureOfUPSI = event.detail.value;
    }
    
    handleDetailChange(event){
        this.detailsOfUPSI = event.detail.value;
    }
    
    handleLegitimateChange(event){
        this.legitimatePurposeOfSharingUPSI = event.detail.value;
    }
    
    handleAttachmentChange(event){
        this.attachment = event.detail.value;
    }
    
    handleSupplierNameChange(event){
        this.supplierOfInformationName = event.detail.value;
    }
    
    handleSupplierPANChange(event){
        this.supplierOfInformationPAN = event.detail.value;
    }
    
    handleReceiverNameChange(event){
        this.receiverOfInformationName = event.detail.value;
    }
    
    handleReceiverPANChange(event){
        this.receiverOfInformationPAN = event.detail.value;
    }
    
    handleAuditChange(event){
        this.auditTrail = event.detail.value;
    }
    
    handleNoteChange(event){
        this.notes = event.detail.value;
    }
}