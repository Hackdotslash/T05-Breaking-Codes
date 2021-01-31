<template>
    <div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <h4 class="text-center">All Events</h4>
                </div>
                <div class="col-md-12" v-if="isEvent">
                    <div class="row justify-content-center">
                        <div class="col-md-6" v-for="events in AdminEvents" :key="events">
                            <div v-if="events.status == 2">
                                <center><v-card style="width:400px; background: #FFA55D">
                                    <v-card-text style="color: #000">
                                        <p class="text-center text--primary" style="font-weight:600">
                                            {{ events.title }}
                                        </p>
                                        <p class="text-center">{{ events.description }}</p>
                                        
                                        <div><strong>Location:</strong> {{ events.location }}</div>
                                        <div><strong>Date:</strong> {{ events.date }}</div>
                                        <div><strong>Time:</strong> {{ events.time }}</div>
                                    </v-card-text>
                                    
                                </v-card></center>
                            </div>
                            <div v-else-if="events.status == 1">
                                <center><v-card style="width:400px; background: #6194F5">
                                    <v-card-text style="color: #000">
                                        <p class="text-center text--primary" style="font-weight:600">
                                            {{ events.title }}
                                        </p>
                                        <p class="text-center">{{ events.description }}</p>
                                        
                                        <div><strong>Location:</strong> {{ events.location }}</div>
                                        <div><strong>Date:</strong> {{ events.date }}</div>
                                        <div><strong>Time:</strong> {{ events.time }}</div>
                                    </v-card-text>
                                    
                                </v-card></center>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" v-else>
                    <p class="text-center">No upcoming events</p>
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
        AdminEvents: []
    }),
    created(){
        this.loadEvent();
    },
    methods: {
        loadEvent() {
            fetch(`http://35.208.131.201:3000/admin/get_events`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.ajwt
                }
            })
            .then(res => res.json())
            .then(data => {
                if(data.events.length != 0) {
                    this.AdminEvents = data.events;
                    localStorage.allEvents = JSON.stringify(data.events);
                    this.isEvent = true;
                }   
                console.log(data);
            })
            console.log("Inside created");
        },
        addEvent()
        {
            const formatDate= this.date.split("-");
            const newDate = `${formatDate[2]}-${formatDate[1]}-${formatDate[0]}`;
            console.log(localStorage.ajwt);
            fetch(`http://35.208.131.201:3000/doctor/add_event`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.ajwt,
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