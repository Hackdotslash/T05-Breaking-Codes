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
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Vaccine",
    data: () => ({
        pid: ''
    }),
    methods: {
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
                if(data.success != 1)
                {
                    alert("No data found")
                }
                else {
                    console.log(data);
                }
                
            })
            //console.log(this.pid);
        }
    }
}
</script>

<style scoped>

</style>