<template>
    <div>
        <div class="container">
            <div class="row justify-content-center">
                <div v-for="(item) in data" :key="item">
                    <div class="col-md-12">
                        <v-card class="" style="width:250px">
                            <v-card-text style="color: #000">
                                <p class="text--primary" style="font-weight:600">
                                   {{ item.title }}
                                </p>
                                <p>{{ item.date.split('T')[0] }}</p>
                                <a :href="item.details" target="_blank" style="text-decoration: none;">
                                    <v-btn class="mr-auto" text dense color="#00827f">
                                        View
                                    </v-btn>
                                </a>
                            </v-card-text>
                        </v-card>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'past',
    data: () => ({
        data: {}
    }),
    mounted()
    {
        fetch('https://health-care-auto.herokuapp.com/api/user/'+localStorage.pContact, {
            method: 'GET'
        })
        .then(res => res.json())
        .then(data => {
            console.log(data.userPrescriptions);
            this.data = data.userPrescriptions;
        });

    }
}
</script>
<style scoped>

</style>