<template>
    <div>
        <div class="container" style="padding-bottom:0!important;">
          <div class="row justify-content-center" style="padding-bottom:0!important;">
            
            <div class="col-md-4" style="padding-bottom:0!important;">
              <br><br>
              <h4 class="text-center">Admin Portal - Rural Healthcare</h4>
              <!-- Start Sign In Form -->
              <form action="#" class="fh5co-form animate-box" data-animate-effect="fadeIn">
                <h2>Sign In</h2>
                <div class="form-group">
                  <label for="email" class="sr-only">Email</label>
                  <input type="text" v-model="email" class="form-control" id="email" placeholder="Username" autocomplete="off">
                </div>
                <div class="form-group">
                  <label for="password" class="sr-only">Password</label>
                  <input type="password" v-model="pass" class="form-control" id="password" placeholder="Password" autocomplete="off">
                </div>
                <br><br>
                <div class="form-group">
                  <center><input type="button" @click="login" value="Sign In" class="btn btn-primary"></center>
                </div>
              </form>
              <br><br>
            </div>
          </div>
        </div>
    </div>
</template>
<script>
import Logo from '../../assets/temp.png';
export default {
    name: 'login',
    data: () => ({
        Logo: Logo,
        email: '',
        pass: ''
    }),
    methods: {
        login()
        {
          fetch("http://35.208.131.201:3000/admin/login", {
            method: "POST",
            headers:{
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              username: this.email,
              password: this.pass
            }),
            
          })
          .then(res => res.json())
          .then(data => {
            localStorage.ajwt = data.token;
            console.log(data);
            this.$router.push('/admin/event')
          })
          .catch(() => {
            alert("Invalid inputs");
          });
        }
    }
}
</script>
<style scoped>


a {
  color: #008080;
  -moz-transition: all 0.3s ease;
  -o-transition: all 0.3s ease;
  -webkit-transition: all 0.3s ease;
  -ms-transition: all 0.3s ease;
  transition: all 0.3s ease;
}
a:hover {
  color: #008080;
}

.menu {
  padding: 0;
  margin: 30px 0 0 0;
}
.menu li {
  list-style: none;
  margin-bottom: 10px;
  display: -moz-inline-stack;
  display: inline-block;
  zoom: 1;
  *display: inline;
}
.menu li a {
  padding: 5px;
}
.menu li.active a {
  color: #b3b3b3;
}

.fh5co-form {
  padding: 30px;
  margin-top: 4em;
  -webkit-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  -o-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  background: #ffffff;
}
.style-2 .fh5co-form {
  -webkit-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  -o-box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
  box-shadow: -4px 7px 46px 2px rgba(0, 0, 0, 0.1);
}
@media screen and (max-width: 768px) {
  .fh5co-form {
    padding: 15px;
  }
}
.fh5co-form h2 {
  text-transform: uppercase;
  letter-spacing: 2px;
  font-size: 20px;
  margin: 0 0 30px 0;
  color: #000000;
}
.fh5co-form .form-group {
  margin-bottom: 30px;
}
.fh5co-form .form-group p {
  font-size: 14px;
  color: #9f9f9f;
  font-weight: 300;
}
.fh5co-form .form-group p a {
  color: #000000;
}
.fh5co-form label {
  font-weight: 300;
  font-size: 14px;
  font-weight: 300;
}
.fh5co-form .form-control {
  font-size: 16px;
  font-weight: 300;
  height: 50px;
  padding-left: 0;
  padding-right: 0;
  border: none;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  -o-box-shadow: none;
  box-shadow: none;
  -webkit-border-radius: 0px;
  -moz-border-radius: 0px;
  -ms-border-radius: 0px;
  border-radius: 0px;
  -moz-transition: all 0.3s ease;
  -o-transition: all 0.3s ease;
  -webkit-transition: all 0.3s ease;
  -ms-transition: all 0.3s ease;
  transition: all 0.3s ease;
}
.fh5co-form .form-control::-webkit-input-placeholder {
  color: rgba(0, 0, 0, 0.3);
  text-transform: uppercase;
}
.fh5co-form .form-control::-moz-placeholder {
  color: rgba(0, 0, 0, 0.3);
  text-transform: uppercase;
}
.fh5co-form .form-control:-ms-input-placeholder {
  color: rgba(0, 0, 0, 0.3);
  text-transform: uppercase;
}
.fh5co-form .form-control:-moz-placeholder {
  color: rgba(0, 0, 0, 0.3);
  text-transform: uppercase;
}
.fh5co-form .form-control:focus, .fh5co-form .form-control:active {
  border-bottom: 1px solid rgba(0, 0, 0, 0.4);
}

.btn-primary {
  height: 50px;
  padding-right: 20px;
  padding-left: 20px;
  border: none;
  background: #008080;
  color: #ffffff;
  -webkit-box-shadow: -2px 10px 20px -1px rgba(51, 204, 204, 0.4);
  -moz-box-shadow: -2px 10px 20px -1px rgba(51, 204, 204, 0.4);
  -o-box-shadow: -2px 10px 20px -1px rgba(51, 204, 204, 0.4);
  box-shadow: -2px 10px 20px -1px rgba(51, 204, 204, 0.4);
}
.btn-primary:hover, .btn-primary:focus, .btn-primary:active {
  color: #ffffff;
  background: #008080 !important;
  outline: none;
}

input, textarea {
  color: #000;
}

.placeholder {
  color: #aaa;
}

.js .animate-box {
  opacity: 0;
}

/*# sourceMappingURL=style.css.map */

</style>