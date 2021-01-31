<template>
    <div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <v-form>
                        <v-text-field v-model="pid" label="Patient ID" required color="#008080"></v-text-field>
                        <center>
                            <v-btn color="#008080" class="mr-4" @click="search">
                                <span style="color: white">Search</span>
                            </v-btn>
                        </center>
                    </v-form>
                </div>
                <div class="col-md-12" v-if="showVaccine">
                    <div class="row justify-content-center">
                        <div class="col-md-12">
                            <h5 class="text-center">Patient's Vaccine history</h5>
                        </div>
                        <div class="col-md-6" v-for="vac in vaccines" :key="vac._id">
                            <center>
                                <v-card style="width:400px">
                                    <v-card-text style="color: #000">
                                        <!-- <p class="text-center text--primary" style="font-weight:600">
                                            {{ vac.name }}
                                        </p> -->
                                        <div><strong>Name:</strong> {{ vac.name }}</div>
                                        <div><strong>Date:</strong> {{ vac.date }}</div>
                                        <br>
                                        <div><strong>Reminders:</strong> 
                                            <div v-for="rem in vac.reminders" :key="rem">
                                                {{ rem }}
                                            </div>
                                        </div>
                                        <br>
                                        <v-row>
                                            <v-col md="6">
                                                <div><strong>Shots taken:</strong> 
                                                    <div v-for="shot in vac.shots" :key="shot">
                                                        <div v-if="shot.status == 1">
                                                            {{ shot.date }}
                                                        </div>
                                                    </div>
                                                </div>
                                            </v-col>
                                            <v-col md="6">
                                                <div><strong>Shots pending:</strong> 
                                                    <div v-for="shot in vac.shots" :key="shot">
                                                        <div v-if="shot.status == 0">
                                                            {{ shot.date }} 
                                                            
                                                            <v-icon @click="addShot(shot.date, vac._id)">mdi-shield-plus</v-icon>
                                                            <v-spacer></v-spacer>
                                                            <v-spacer></v-spacer>
                                                        </div>
                                                    </div>
                                                </div>
                                            </v-col>
                                        </v-row>
                                        <br><br>
                                        
                                    </v-card-text>
                                    
                                </v-card>
                            </center>
                        </div>
                        <div class="col-md-12">
                            <center>
                                <v-dialog v-model="dialog" max-width="600px" >
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-btn class="ma-2" color="#008080" v-bind="attrs" v-on="on" dark  @click="showForm = !showForm">
                                            Add New vaccine
                                            <v-icon dark right > mdi-plus </v-icon>
                                        </v-btn>
                                    </template>
                                    <v-card>
                                        <v-card-title>
                                            <span class="headline">Vaccine Details</span>
                                        </v-card-title>
                                        <v-card-text>
                                        <v-container>
                                            <v-row>
                                                <v-col cols="12" sm="8" md="6">
                                                    <v-text-field color="#008080" label="Vaccine Name" v-model="vname" required></v-text-field>
                                                </v-col>
                                                <v-col cols="12" sm="8" md="6">
                                                    <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                                                        <template v-slot:activator="{ on, attrs }">
                                                            <v-text-field v-model="date" label="Date" color="#008080" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                                                        </template>
                                                        <v-date-picker color="#008080" v-model="date" no-title scrollable >
                                                            <v-spacer></v-spacer>
                                                            <v-btn color="#008080" text @click="$refs.menu.save(date)" >
                                                                OK
                                                            </v-btn>
                                                        </v-date-picker>
                                                    </v-menu>
                                                </v-col>
                                                <v-col cols="12" sm="8" md="8">
                                                    <v-text-field color="#008080" label="Comments" v-model="vcom" required></v-text-field>
                                                </v-col>
                                                <v-col class="d-flex" cols="12" sm="8" >
                                                    <v-select color="#008080" :items="sList" v-model="valShot" label="No. of Shots"></v-select>
                                                </v-col>
                                                <v-col class="d-flex" cols="12" sm="6" v-for="val in valShot" :key="val">
                                                    <v-text-field color="#008080" label="Next shot date" :id="val" required></v-text-field>
                                                </v-col>
                                            </v-row>
                                        </v-container>
                                        </v-card-text>
                                        <v-card-actions>
                                        <v-spacer></v-spacer>
                                        <v-btn color="#008080 darken-1" text @click="dialog = false">
                                            Close
                                        </v-btn>
                                        <v-btn color="#008080 darken-1" text @click="addVac">
                                            Upload
                                        </v-btn>
                                        </v-card-actions>
                                    </v-card>
                                </v-dialog>
                                <br><br><br>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Vaccine",
    data: () => ({
        pid: '',
        vaccines: [],
        showVaccine: false,
        dialog: false,
        date: '',
        vcom: '',
        vname: '',
        menu: false,
        valShot: 0,
        sList: [1,2,3,4,5]
    }),
    methods: {
        addShot(sDate, sId)
        {
            fetch(`http://35.208.131.201:3000/doctor/add_shot`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.jwt,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    vaccine: sId,
                    date: sDate,
                    status: 1
                })
            })
            .then(res => res.json())
            .then(data => {
                console.log(data);
                this.search();
            })
        },
        addVac()
        {
            const reminders = [];
            for(let i=1; i<= this.valShot; i++)
            {
                console.log(document.getElementById(i).value);
                reminders.push(document.getElementById(i).value);
            }
            fetch(`http://35.208.131.201:3000/doctor/add_vaccine`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.jwt,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    patient: this.pid,
                    name: this.vname,
                    date: this.date,
                    reminders: reminders,
                    comments: this.vcom
                })
            })
            .then(res => res.json())
            .then(data => {
                this.dialog = false;
                if(data.success == 1){
                    alert("Vaccine added succesfully");
                    this.vname = '';
                    this.date = '';
                    this.valShot = 0
                    this.search();
                }
            })
            console.log(reminders);
        },
        search()
        {
            fetch(`http://35.208.131.201:3000/doctor/get_patient_vaccines`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.jwt,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    patient: this.pid
                })
            })
            .then(res => res.json())
            .then(data => {
                this.vaccines = data.vaccines
                console.log(this.vaccines);
                this.showVaccine = true;
                // if(data.success != 1)
                // {
                //     alert("No data found")
                // }
                // else {
                    
                // }
                
            })
            //console.log(this.pid);
        }
    }
}
</script>

<style scoped>

</style>