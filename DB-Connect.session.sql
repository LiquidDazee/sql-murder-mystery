use sqlmurdermystery;

select * from crime_scene_report where city = 'SQL City' and date = 20180115 and type='murder';
-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

select * from person where address_street_name = 'Northwestern Dr' order by address_number desc LIMIT 1;
/*
{
  "id": 14887,
  "name": "Morty Schapiro",
  "license_id": 118009,
  "address_number": 4919,
  "address_street_name": "Northwestern Dr",
  "ssn": 111564949
}
*/

select * from person where address_street_name = 'Franklin Ave' and name like 'Annabel%';
/*
{
  "id": 16371,
  "name": "Annabel Miller",
  "license_id": 490173,
  "address_number": 103,
  "address_street_name": "Franklin Ave",
  "ssn": 318771143
}
*/

select * from get_fit_now_member where person_id = 14887 or person_id = 16371 LIMIT 5;
/*{
  "id": "90081",
  "person_id": 16371,
  "name": "Annabel Miller",
  "membership_start_date": 20160208,
  "membership_status": "gold"
}*/
-- Annabel is a member, searching for alibi

select * from get_fit_now_check_in where membership_id = 90081 and check_in_date = 20180115;
-- No result, Annabel wasnt at the gym during the murder

select p.name, i.transcript from interview i join person p on i.person_id = p.id
where person_id = 14887 or person_id = 16371;

/*{
  "name": "Morty Schapiro",
  "transcript": "I heard a gunshot and then saw a man run out. He had a \"Get Fit Now Gym\" bag. The membership number on the bag started with \"48Z\". Only gold members have those bags. The man got into a car with a plate that included \"H42W\"."
}
{
  "name": "Annabel Miller",
  "transcript": "I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th."
}*/

select g.*, m.name from get_fit_now_check_in g join get_fit_now_member m on  g.membership_id = m.id
where check_in_date = 20180109;

/*{
  "membership_id": "48Z7A",
  "check_in_date": 20180109,
  "check_in_time": 1600,
  "check_out_time": 1730,
  "name": "Joe Germuska"
}
{
  "membership_id": "48Z55",
  "check_in_date": 20180109,
  "check_in_time": 1530,
  "check_out_time": 1700,
  "name": "Jeremy Bowers"
}*/

select p.name, d.* from person p right JOIN drivers_license d on p.license_id = d.id where d.plate_number like '%H42W%';

-- This returns Jeremy Bowers, Maxine Whitely and Tushar Chandra, of which only Jeremy Bowers was at the gym when Annabel mentioned

INSERT INTO solution VALUES (1, "Jeremy Bowers");

SELECT value FROM solution;

/*
Congrats, you found the murderer! But wait, there's more... .
If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. 
If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 
Use this same INSERT statement with your new suspect to check your answer.
*/

select p.name, i.transcript from person p join interview i on p.id = i.person_id where p.name = 'Jeremy Bowers';

/*
{
  "name": "Jeremy Bowers",
  "transcript": "I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5\" (65\") or 5'7\" (67\"). 
                She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.\n"
}
*/

select * from person p join drivers_license d on p.license_id = d.id join facebook_event_checkin f on f.person_id=p.id join income i on p.ssn = i.ssn
where d.car_make = 'Tesla' and f.event_name like '%SQL%';

-- Miranda Priestly

INSERT INTO solution VALUES (1, 'Miranda Priestly');

SELECT value FROM solution;

-- Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!