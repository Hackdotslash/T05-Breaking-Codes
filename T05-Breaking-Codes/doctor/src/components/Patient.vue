<template>
    <div>
        <div class="container">
            <h4 class="text-center">Patient Details</h4>
            <br>
            <div class="row justify-content-center">
                <div class="col-md-3">
                    <span class="h5">Name:</span>&nbsp; <span class="pl-2 p">{{ pName }}</span>
                </div>
                <div class="col-md-3">
                    <span class="h5">Age:</span>&nbsp; <span class="pl-2 p">{{ pAge }}</span>
                </div>
                <div class="col-md-3">
                    <span class="h5">Phone:</span>&nbsp; <span class="pl-2 p">{{ pPhone }}</span>
                </div>
                <div class="col-md-3">
                    <span class="h5">Email:</span>&nbsp; <span class="pl-2 p">{{ pEmail }}</span>
                </div>
            </div>
            <br>
            <div class="row">
                <span class="h5 pl-3">Reports:</span>&nbsp;
            </div>
            <br>
            <div class="row justify-content-center">
                <div v-for="item in reports" :key="item">
                    <div class="col-md-12">
                        <v-card class="" max-width="500">
                            <v-card-text>
                            <p class="h5 text--primary">
                                {{item.title}}
                            </p>
                            <p>{{ item.date }}</p>
                            </v-card-text>
                            <v-card-actions>
                            <a :href="item.file" target="_blank" style="text-decoration: none">
                            <v-btn text dense color="#00827f">
                                View Report
                            </v-btn>
                            </a>
                            
                            <v-btn class="ml-auto" text dense color="#00827f" @click="presc(item.title)">
                                Prescrip
                            </v-btn>
                            </v-card-actions>
                        </v-card>
                    </div>
                </div>
                
            </div>
            <br><br>
            
        </div>
    </div>    
</template>
<script>
export default {
    name: 'Patient',
    data: () => ({
        pName: '',
        pAge: '',
        pPhone: '',
        pEmail: '',
        reports: {},
        url: 'https://cdn.urldecoder.org/assets/images/url-fb.png'
    }),
    created()
    {
        console.log(localStorage.jwt);
        fetch('https://health-care-auto.herokuapp.com/api/doctor/userDetails',{
            headers: {
                'X-Auth-Token': localStorage.jwt,
                'Content-Type': 'application/json'
            },
            method: 'GET'
        })
        .then(res => res.json())
        .then(data => {
            console.log(data);
            localStorage.pName = data.user.name;
            localStorage.pAge = data.user.age;
            localStorage.pContact = data.user.contact;
            localStorage.pID = data.user._id;

            this.pName = data.user.name;
            this.pAge = data.user.age;
            this.pPhone = data.user.contact;
            this.pEmail = data.user.email;
            console.log(data.report);
            this.reports = data.report;
        })
        .catch(err => console.log(err));

    },
    methods: {
        presc(title)
        {
            localStorage.prescTitle = title;
            console.log(localStorage.prescTitle);
            this.$router.push('/profile/presc');
        }
    }
}
</script>
<style scoped>

</style>