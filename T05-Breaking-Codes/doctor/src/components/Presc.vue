<template>
    <div>
        <v-form>
        <v-container>
            <h4 class="text-center pt-2">Prescription for {{ pName }} - {{ pTitle }}</h4>
            <v-row class="row justify-content-center">
                <v-col
                cols="12"
                md="8"
                >
                    <v-text-field
                        v-model="views"
                        label="Views on Report"
                        required
                        color="#00827f"
                    ></v-text-field>
                </v-col>

                <v-col
                cols="12"
                md="8"
                >
                    <v-text-field
                        v-model="specialCare"
                        label="Special Care"
                        required
                        color="#00827f"
                    ></v-text-field>
                </v-col>

                <v-col
                cols="12"
                md="8"
                >
                    <v-text-field
                        v-model="allergy"
                        label="Allergies"
                        required
                        color="#00827f"
                    ></v-text-field>
                </v-col>

                <v-col
                cols="12"
                md="8"
                >
                    <v-text-field
                        v-model="medicines"
                        label="Medical Suggestions"
                        required
                        color="#00827f"
                    ></v-text-field>
                </v-col>
                
                <v-col
                cols="12"
                md="8"
                >
                    <v-btn
                        color="#00827f"
                        class="mr-4"
                        @click="submit"
                    >
                        <span style="color: #fff;">Submit</span>
                    </v-btn>
                    <v-btn
                        color="cancel"
                        class="mr-4"
                        @click="reset"
                    >
                        Reset
                    </v-btn>
                </v-col>

                <v-col
                cols="12"
                md="8"
                >
                    
                </v-col>
            </v-row>
            
        </v-container>
    </v-form>
    
    <div style="display:none" ref="target">
        <div class="container pt-4" ref="content">
            <h2 class="text-center" style="color:#00827f">Rural Healthcare</h2>
            <br>
            <h5>Prescription for {{pTitle}}</h5>
            <div style="color: #fff;font-weight: 600">Report</div>
            <span><span class="h5" style="font-weight: 600">Dr. {{ docName }}</span>&nbsp; - &nbsp;<span>{{ docSpecs }}</span></span> <br>	
            <span class="mx-auto">{{ docEmail }}</span>
            <hr style="border: 2px solid #00827f">
            <div style="color: #fff;font-weight: 600">Report</div>
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <span style="font-weight: 600">Patient Name:</span>&nbsp; {{ pName }}
                </div>
                <div class="col-md-4">
                    <span style="font-weight: 600">Age:</span>&nbsp; {{ pAge }}
                </div>
                <div class="col-md-4">
                    <span style="font-weight: 600">Contact:</span>&nbsp; {{ pContact }}
                </div>
            </div>
            <br><br>
            <div class="row">
                <div class="col-md-12">
                    <p><span style="font-weight: 600">Views on Report:</span>&nbsp; {{ views }}</p>
                </div>
                <div class="col-md-12">
                    <p><span style="font-weight: 600">Special Care:</span>&nbsp; {{ specialCare }}</p>
                </div>
                <div class="col-md-12">
                    <p><span style="font-weight: 600">Allergies:</span>&nbsp; {{ allergy }}</p>
                </div>
                <div class="col-md-12">
                    <p><span style="font-weight: 600">Medical suggestions:</span>&nbsp; {{ medicines }}</p>
                </div>
            </div>
            <hr style="border: 2px solid #00827f">
            <div style="color: #fff;font-weight: 600">Report</div>
            <h3 class="text-center">Get well soon, Regards <span style="color:#00827f">Rural Healthcare</span></h3>
            
        </div>
    </div>
    </div>
</template>
<script>
import jsPDF from 'jspdf'
// import pdfkit from 'pdfkit'
import firebase from 'firebase'
export default {
    name: 'presc',
    data: () => ({
      views: '',
      specialCare: '',
      allergy: '',
      medicines: '',
      docName: localStorage.docName,
      docSpecs: localStorage.docSpecs,
      docEmail: localStorage.docEmail,
      pName: localStorage.pName,
      pAge: localStorage.pAge,
      pContact: localStorage.pContact,
      pTitle: localStorage.prescTitle
    }),
    methods:{
        reset()
        {
            this.views = '';
            this.specialCare = '';
            this.allergy = '';
            this.medicines = '';
        },
        submit()
        {
            // var doc = new jsPDF();

            
            // doc.text('Hello world!', 10, 10)
            // console.log(doc.text);
            

            var pdf = new jsPDF();
            const html = this.$refs.content.innerHTML;
            pdf.fromHTML(html, 15,15,{
                width: 150
            });
            this.uploadFile(pdf.output('blob'));

        },
        uploadFile(pdf)
        {
            console.log(pdf);
            var d = new Date();
            var n = d.getTime();
            var storageRef = firebase.storage().ref('/'+n);
            storageRef.put(pdf).then(function(snapshot) {
            console.log('Uploaded a blob or file!');
            return snapshot.ref.getDownloadURL()
            }).then((dataPDF => {
                console.log(dataPDF);
                fetch("https://health-care-auto.herokuapp.com/api/doctor/prescription", {
                    method: "POST",
                    headers:{
                        'X-Auth-Token': localStorage.jwt,
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        prescription:{
                            title: "Prescription for "+localStorage.prescTitle,
                            details: dataPDF
                        },
                        userId: localStorage.pID
                    })
                    
                })
                .then(res => res.json())
                .then(data => {
                    console.log(data);
                });
            }));
        }
    }
}
</script>
<style scoped>

</style>