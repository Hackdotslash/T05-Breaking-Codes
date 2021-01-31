const child_process = require('child_process');
const comFun = require('../commonFunctions');
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);

module.exports.disease_predict = (req,res,next)=> {
    if (!comFun.NotNullUndef(req.body.Body)) {
        console.log('No Symptoms');
        res.json({success: 0, messages: "NO symptoms"})
    }
    else {
        console.log(req.body.Body);
        const input = req.body.Body;
        let inputsymp = input.split(',');
        let symptoms = [
            'itching',
            'skin_rash',
            'nodal_skin_eruptions',
            'continuous_sneezing',
            'shivering',
            'chills',
            'joint_pain',
            'stomach_pain',
            'acidity',
            'ulcers_on_tongue',
            'muscle_wasting',
            'vomiting',
            'burning_micturition',
            'spotting_urination',
            'fatigue',
            'weight_gain',
            'anxiety',
            'cold_hands_and_feets',
            'mood_swings',
            'weight_loss',
            'restlessness',
            'lethargy',
            'patches_in_throat',
            'irregular_sugar_level',
            'cough',
            'high_fever',
            'sunken_eyes',
            'breathlessness',
            'sweating',
            'dehydration',
            'indigestion',
            'headache',
            'yellowish_skin',
            'dark_urine',
            'nausea',
            'loss_of_appetite',
            'pain_behind_the_eyes',
            'back_pain',
            'constipation',
            'abdominal_pain',
            'diarrhoea',
            'mild_fever',
            'yellow_urine',
            'yellowing_of_eyes',
            'acute_liver_failure',
            'fluid_overload',
            'swelling_of_stomach',
            'swelled_lymph_nodes',
            'malaise',
            'blurred_and_distorted_vision',
            'phlegm',
            'throat_irritation',
            'redness_of_eyes',
            'sinus_pressure',
            'runny_nose',
            'congestion',
            'chest_pain',
            'weakness_in_limbs',
            'fast_heart_rate',
            'pain_during_bowel_movements',
            'pain_in_anal_region',
            'bloody_stool',
            'irritation_in_anus',
            'neck_pain',
            'dizziness',
            'cramps',
            'bruising',
            'obesity',
            'swollen_legs',
            'swollen_blood_vessels',
            'puffy_face_and_eyes',
            'enlarged_thyroid',
            'brittle_nails',
            'swollen_extremeties',
            'excessive_hunger',
            'extra_marital_contacts',
            'drying_and_tingling_lips',
            'slurred_speech',
            'knee_pain',
            'hip_joint_pain',
            'muscle_weakness',
            'stiff_neck',
            'swelling_joints',
            'movement_stiffness',
            'spinning_movements',
            'loss_of_balance',
            'unsteadiness',
            'weakness_of_one_body_side',
            'loss_of_smell',
            'bladder_discomfort',
            'foul_smell_of urine',
            'continuous_feel_of_urine',
            'passage_of_gases',
            'internal_itching',
            'toxic_look_(typhos)',
            'depression',
            'irritability',
            'muscle_pain',
            'altered_sensorium',
            'red_spots_over_body',
            'belly_pain',
            'abnormal_menstruation',
            'dischromic _patches',
            'watering_from_eyes',
            'increased_appetite',
            'polyuria',
            'family_history',
            'mucoid_sputum',
            'rusty_sputum',
            'lack_of_concentration',
            'visual_disturbances',
            'receiving_blood_transfusion',
            'receiving_unsterile_injections',
            'coma',
            'stomach_bleeding',
            'distention_of_abdomen',
            'history_of_alcohol_consumption',
            'fluid_overload',
            'blood_in_sputum',
            'prominent_veins_on_calf',
            'palpitations',
            'painful_walking',
            'pus_filled_pimples',
            'blackheads',
            'scurring',
            'skin_peeling',
            'silver_like_dusting',
            'small_dents_in_nails',
            'inflammatory_nails',
            'blister',
            'red_sore_around_nose',
            'yellow_crust_ooze',
        ]
        let sympArr = ''
        symptoms.forEach(symp=>{
            if(inputsymp.includes(symp)){
                sympArr+='1,'
            }else{
                sympArr+='0,';
            }
        })
        sympArr = sympArr.slice(0,-1)
        console.log(sympArr)
        let spawn = child_process.spawn;
        let process = spawn('python3', ['./diseasePredict/main.py', sympArr])

        process.stdout.on('data', function (data) {

            let disease = data.toString()
            disease = disease.slice(2,disease.length-3);

            console.log(disease);
            let homeRemedyLink = `https://google.com/search?q=Home%20Remedy%20For%20${disease}`
            let message=`You are diagnosed with *${disease}* \n\nYou may find useful remedies on ${homeRemedyLink}\n\nHope you get well soon\n\n-Virual Doctor(Breaking Codes)`

            client.messages
                .create({
                    from: 'whatsapp:+14155238886',
                    body: message,
                    to: 'whatsapp:+919820145991'
                })
                .then(message => {
                    res.json({success: 1,})
                })
                .catch(err=>{
                    console.error(err)
                    res.json({success: 0,})
                })
        })

    }
}