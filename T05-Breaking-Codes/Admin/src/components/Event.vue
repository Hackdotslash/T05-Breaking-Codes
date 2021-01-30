<template>
    <div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <h4 class="text-center">My Events</h4>
                </div>
                <div class="col-md-12" v-if="isEvent">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <center><v-card class="" style="width:400px">
                                <v-card-text style="color: #000">
                                    <p class="text-center text--primary" style="font-weight:600">
                                        Blood donation drive
                                    </p>
                                    <p class="text-center">Blood donation drive at Borivali station on 3rd Feb, 2021</p>
                                    
                                    <div><strong>Location:</strong> Borivali station</div>
                                    <div><strong>Date:</strong> 3rd Feb, 2021</div>
                                    <div><strong>Time:</strong> 3pm onwards</div>
                                </v-card-text>
                                
                            </v-card></center>
                        </div>
                        <div class="col-md-6">
                            <center><v-card class="" style="width:400px">
                                <v-card-text style="color: #000">
                                    <p class="text-center text--primary" style="font-weight:600">
                                        Blood donation drive
                                    </p>
                                    <p class="text-center">Blood donation drive at Borivali station on 3rd Feb, 2021</p>
                                    
                                    <div><strong>Location:</strong> Borivali station</div>
                                    <div><strong>Date:</strong> 3rd Feb, 2021</div>
                                    <div><strong>Time:</strong> 3pm onwards</div>
                                </v-card-text>
                                
                            </v-card></center>
                        </div>
                        <div class="col-md-6">
                            <center><v-card class="" style="width:400px">
                                <v-card-text style="color: #000">
                                    <p class="text-center text--primary" style="font-weight:600">
                                        Blood donation drive
                                    </p>
                                    <p class="text-center">Blood donation drive at Borivali station on 3rd Feb, 2021</p>
                                    
                                    <div><strong>Location:</strong> Borivali station</div>
                                    <div><strong>Date:</strong> 3rd Feb, 2021</div>
                                    <div><strong>Time:</strong> 3pm onwards</div>
                                </v-card-text>
                                
                            </v-card></center>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" v-else>
                    <p class="text-center">No upcoming events</p>
                </div>

                <br><br>
                <div class="col-md-12">
                    <center>
                        <v-btn class="ma-2" color="#008080" dark  @click="showForm = !showForm">
                            Add Event
                            <v-icon dark right > mdi-plus </v-icon>
                        </v-btn>
                    </center>
                </div>
                <div class="col-md-12">
                    <div v-if="showForm">
                        <div class="row justify-content-center">
                            <div class="col-md-7">
                                <v-form>
                                    <v-text-field v-model="title" label="Event Title" required color="#008080"></v-text-field>
                                    <v-text-field v-model="desc" label="Event Description" required color="#008080"></v-text-field>
                                    <v-text-field v-model="loc" label="Location" required color="#008080"></v-text-field>
                                    <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="date" label="Event Date" color="#008080" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker color="#008080" v-model="date" no-title scrollable >
                                            <v-spacer></v-spacer>
                                            <v-btn color="#008080" text @click="$refs.menu.save(date)" >
                                                OK
                                            </v-btn>
                                        </v-date-picker>
                                    </v-menu>
                                    <v-text-field v-model="time" label="Event Time" required color="#008080"></v-text-field>
                                    <center>
                                        <v-btn color="#008080" class="mr-4" @click="addEvent">
                                            <span style="color: white">Submit for review</span>
                                        </v-btn>
                                    </center>
                                </v-form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Event',
    data: () => ({
        isEvent: true,
        showForm: false,
        date: '',
        menu: false,
        title: '',
        time: '',
        loc: '',
        desc: ''
    }),
    created(){
        this.loadEvent();
    },
    methods: {
        loadEvent() {
            console.log("Inside created");
        },
        addEvent()
        {
            const formatDate= this.date.split("-");
            const newDate = `${formatDate[2]}-${formatDate[1]}-${formatDate[0]}`;
            console.log(localStorage.jwt);
            fetch(`http://35.208.131.201:3000/doctor/add_event`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.jwt,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    title: this.title,
                    date: newDate,
                    description: this.desc,
                    location: this.loc,
                   time: this.time
                 })
            })
            .then(res => res.json())
                .then(data => {
                    console.log(data);
                    if(data.success == 1)
                    {
                        alert("New event has been added, it'll be reviewed");
                        this.showForm = false;
                        this.title = '';
                        this.date = '';
                        this.time = '';
                        this.loc = '';
                        this.desc = '';
                        this.$router.push('/admin/event');
                    }
                })
        }
    }
}
</script>

<style scoped>

</style>