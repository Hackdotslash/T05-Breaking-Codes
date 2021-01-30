<template>
    <div>
        <div class="container">
            
            <div class="row justify-content-center">
                <div v-for="item in data" :key="item">
                    <div class="col-md-12">
                        <v-card class="" style="width:250px">
                            <v-card-text style="color: #000">
                                <p class="text-center text--primary" style="font-weight:600">
                                    {{item.date.split('T')[0]}}
                                </p>
                                <p class="text-center">{{ item.Summary }}</p>
                                <div>Scores:</div>
                                <div class><strong>Positive:</strong> {{ item.scores.pos*100 || 0 }}%</div>
                                <div><strong>Neutral:</strong> {{ item.scores.neu*100 || 0 }}%</div>
                                <div><strong>Negative:</strong> {{ item.scores.neg*100 || 0 }}%</div>
                                <br>
                                <div><strong>Keywords:</strong>
                                    <ul>
                                        <li v-for="i in item.ent_list" :key="i">{{i}}</li>
                                    </ul>
                                </div>
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
    name: 'diary',
    data: () => ({
        data: {}
    }),
    mounted()
    {
        fetch('https://health-care-auto.herokuapp.com/api/diary/doc/clientDetail',{
            headers: {
                    'X-Auth-Token': localStorage.jwt,
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                method: 'GET'
        })
        .then(res => res.json())
        .then(data => {
            console.log(data);
            this.data = data;

        });
    }
}
</script>
<style scoped>

</style>