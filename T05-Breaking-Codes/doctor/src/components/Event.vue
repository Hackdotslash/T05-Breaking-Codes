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
                                    <v-text-field v-model="email" label="Event Title" required color="#008080"></v-text-field>
                                    <center>
                                        <v-btn color="#008080" class="mr-4" @click="validate">
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
        isEvent: false,
        showForm: false
    }),
    created(){
        console.log("Inside created");
    },
    methods: {
        addEvent()
        {
            console.log("Inside Event");
        }
    }
}
</script>

<style scoped>

</style>