<template>
    <div>
        <v-navigation-drawer
            v-model="drawer"
            app
        >
            <v-list dense>
                <router-link to="/profile/patient" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-account</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Patient Details</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link>
                
                    <v-list-item link @click="revoke()">
                        <v-list-item-action>
                        <v-icon>mdi-logout</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Revoke Patient</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                
                <router-link to="/profile/past" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-book</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Past Prescription</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link>
                <router-link to="/profile/diary" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-notebook</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Personal Diary</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link>

                <v-list-item link @click="logout()">
                    <v-list-item-action>
                    <v-icon>mdi-lock</v-icon>
                    </v-list-item-action>
                    <v-list-item-content>
                    <v-list-item-title>Logout</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>
        <v-app-bar
            app
            color="#00827f"
            dark
        >
            <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>Secure Health</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-title class="pr-2">Welcome Dr. {{ docName }}</v-toolbar-title>

        </v-app-bar>
        <router-view></router-view>
        <v-footer
            color="#00827f"
            app
        >
            
            <center><span class="white--text">&copy; Breaking Codes</span></center>
        </v-footer>
    </div>
</template>
<script>
export default {
    data: () => ({
        drawer: false,
        docName: localStorage.docName
    }),
    methods:{
        logout()
        {
            this.$router.push('/');
            localStorage.jwt = '';
            localStorage.docEmail = '';
            localStorage.docPass = '';
            localStorage.docName= '';
            localStorage.docSpecs = '';
            localStorage.docID = '';
            localStorage.pName = '';
            localStorage.pAge = '';
            localStorage.pContact = '';
            localStorage.pID = '';
        },
        revoke()
        {
            fetch('https://health-care-auto.herokuapp.com/api/user/removeCurrentDoctor',{
                method: 'POST',
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    userId: localStorage.pID
                })
            })
            .then(res => res.json())
            .then(data => {
                console.log(data);
                this.$router.push('/');
            })
            
        }
    }
}
</script>
<style scoped>

</style>