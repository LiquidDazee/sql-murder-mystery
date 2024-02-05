# SQL-Murder-Mystery
Challenge website:
[The SQL Murder Mystery](https://mystery.knightlab.com/)

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

This is the solution for the above linked mystery and contains SPOILERS of it.

1. Search for information about a murder on 15 January 2018:

```SQL
select * from crime_scene_report 
where city = 'SQL City' and date = 20180115 and type='murder';
```
Result:
| Date       | Type   | Description                                                           | City      |
|------------|--------|-----------------------------------------------------------------------|-----------|
| 20180115   | Murder | Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". | SQL City  |

2. Seek the witnesses:

The first witness:
```SQL
select * from person 
where address_street_name = 'Northwestern Dr' order by address_number desc LIMIT 1;
```
Result:
| ID    | Name           | License ID | Address Number | Address Street Name | SSN        |
|-------|----------------|------------|-----------------|----------------------|------------|
| 14887 | Morty Schapiro | 118009     | 4919            | Northwestern Dr     | 111564949  |

The second witness:
```SQL
select * from person 
where address_street_name = 'Franklin Ave' and name like 'Annabel%';
```
Result:
| ID    | Name           | License ID | Address Number | Address Street Name | SSN        |
|-------|----------------|------------|-----------------|----------------------|------------|
| 16371 | Annabel Miller | 490173     | 103             | Franklin Ave         | 318771143  |


3. Witnesses - interview:

```SQL
select p.name, i.transcript from interview i 
join person p on i.person_id = p.id
where person_id = 14887 or person_id = 16371;
```
Result:
| Name            | Transcript                                                                                                                          |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------|
| Morty Schapiro  | I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W". |
| Annabel Miller  | I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.                  |

4. Check details given from interviews:

```SQL
select g.*, m.name from get_fit_now_check_in g 
join get_fit_now_member m on  g.membership_id = m.id
where check_in_date = 20180109 and membership_id like '48Z%';
```
Result:
| Membership ID | Check-in Date | Check-in Time | Check-out Time | Name            |
|---------------|---------------|---------------|----------------|-----------------|
| 48Z7A         | 20180109      | 1600          | 1730           | Joe Germuska    |
| 48Z55         | 20180109      | 1530          | 1700           | Jeremy Bowers   |

```SQL
select p.name, d.* from person p 
right JOIN drivers_license d on p.license_id = d.id 
where d.plate_number like '%H42W%';
```
Result:
| Name             | ID     | Age | Height | Eye Color | Hair Color | Gender | Plate Number | Car Make   | Car Model    |
|------------------|--------|-----|--------|-----------|------------|--------|--------------|------------|--------------|
| Jeremy Bowers    | 423327 | 30  | 70     | brown     | brown      | male   | 0H42W2       | Chevrolet  | Spark LS      |
| Maxine Whitely   | 183779 | 21  | 65     | blue      | blonde     | female | H42W0X       | Toyota     | Prius        |
| Tushar Chandra   | 664760 | 21  | 71     | black     | black      | male   | 4H42WR       | Nissan     | Altima       |

5. The only overlap is Jeremy Bowers, check solution:
```SQL
INSERT INTO solution VALUES (1, 'Jeremy Bowers')
SELECT value
FROM solution;
```
Result:
| value |
| :---: | 
| Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer. |

6. Murderer Interview:
```SQL
select p.name, i.transcript from person p 
join interview i on p.id = i.person_id 
where p.name = 'Jeremy Bowers';
```
Result:
| Name             | Transcript                                                                                                                                          |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Jeremy Bowers    | I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. |

7. Check woman
```SQL
select p.name, d.car_make, d.car_model, d.height, d.hair_color, f.event_name, i.annual_income from person p 
join drivers_license d on p.license_id = d.id join facebook_event_checkin f on f.person_id=p.id 
join income i on p.ssn = i.ssn
where d.car_make = 'Tesla' and f.event_name like '%SQL%';
```
Result:
| Name              | Car Make | Car Model | Height | Hair Color | Event Name             | Annual Income |
|-------------------|----------|-----------|--------|------------|------------------------|---------------|
| Miranda Priestly | Tesla    | Model S   | 66     | red        | SQL Symphony Concert  | 310000        |

8. Check solution:
```SQL
INSERT INTO solution VALUES (1, 'Miranda Priestly')
SELECT value FROM solution;
```
Result:
| value |
| :---: | 
| Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne! |
