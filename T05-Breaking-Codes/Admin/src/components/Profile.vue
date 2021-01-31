<template>
    <div>
        <v-navigation-drawer
            v-model="drawer"
            app
        >
            <v-list dense>
                
                <router-link to="/admin/pending" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-account-clock</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Pending Events</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link>
                <router-link to="/admin/approved" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-account-check</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Approved Events</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link>
                <!-- <router-link to="/admin/diary" tag="v-list-item">
                    <v-list-item link>
                        <v-list-item-action>
                        <v-icon>mdi-domain</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                        <v-list-item-title>Jobs</v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </router-link> -->
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
            <v-toolbar-title>Admin Portal - Rural Healthcare</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-title class="pr-2">Welcome Admin</v-toolbar-title>

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
            localStorage.ajwt = '';
            localStorage.docEmail = '';
            localStorage.docPass = '';
            localStorage.docName= '';
            localStorage.docSpecs = '';
            localStorage.docID = '';
            localStorage.pName = '';
            localStorage.pAge = '';
            localStorage.pContact = '';
            localStorage.pID = '';
        }
    }
}
</script>
<style scoped>

</style>