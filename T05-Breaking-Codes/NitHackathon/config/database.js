module.exports = (user,pass)=>
{
    return {
        'url': `mongodb+srv://${user}:${pass}@hackathon.ei6dq.mongodb.net/Hack?retryWrites=true&w=majority`
    }
};
