<template>
    <div>
        <div class="container">
            <h4 class="text-center">Personal Details</h4>
            <br><br>
            <h2 class="text-center">Dr. {{ docName }}</h2>
            <br>
            <div class="row justify-content-center pl-16">
                <!-- <div class="col-md-3">
                    <span class="h5">Name:</span>&nbsp; <span class="pl-2 p">{{ docName }}</span>
                </div> -->
                <div class="col-md-4">
                    <div class="col-md-12">
                        <span class="h5">Email:</span>&nbsp; <span class="pl-2 p">{{ docEmail }}</span>
                    </div>
                    <div class="col-md-12">
                        <span class="h5">Contact:</span>&nbsp; <span class="pl-2 p">{{ docContact }}</span>
                    </div>
                    <div class="col-md-12">
                        <span class="h5">Specialization:</span>&nbsp; <span class="pl-2 p">{{ docSpec }}</span>
                    </div>
                    <div class="col-md-12">
                        <span class="h5">Address:</span>&nbsp; <span class="pl-2 p">{{ docAddr }}</span>
                    </div>
                    <div class="col-md-12">
                        <span class="h5">Pin Code:</span>&nbsp; <span class="pl-2 p">{{ docPin }}</span>
                    </div>
                </div>
                
            </div>
        </div>
    </div>    
</template>
<script>
export default {
    name: 'Patient',
    data: () => ({
        docName: localStorage.docName,
        docEmail: localStorage.docEmail,
        docContact : localStorage.contact,
        docAddr: localStorage.docAddr,
        docSpec: localStorage.docSpec,
        docPin: localStorage.docPincode,
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