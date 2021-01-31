<template>
    <div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <h4 class="text-center">Pending Events</h4>
                </div>
                <div class="col-md-12" v-if="isEvent">
                    <div class="row justify-content-center">
                        <div class="col-md-6" v-for="events in pendingEvent" :key="events">
                            <div>
                                <center><v-card style="width:400px;">
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
    name: "Pending",
    data: () => ({
        isEvent: false,
        pendingEvent: []
    }),
    mounted(){
        this.load();
    },
    methods: {
        load()
        {
            this.pendingEvent = [];
            fetch(`http://35.208.131.201:3000/admin/get_events`, {
                method: "POST",
                headers: {
                    "X-Auth-Token": localStorage.ajwt
                }
            })
            .then(res => res.json())
            .then(data2 => {
                const data = data2.events;
                data.forEach(cval => {
                    if(cval.status == 1){
                        this.pendingEvent.push(cval);
                        this.isEvent = true;
                    }
                });
                console.log(this.pendingEvent);
            });
        }
    }
}
</script>

<style scoped>

</style>