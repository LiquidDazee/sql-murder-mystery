# SQL-Murder-Mystery
Challenge website:
[The SQL Murder Mystery](https://mystery.knightlab.com/)

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

1. Search for information about a murder on 15 January 2018:

```SQL
select * from crime_scene_report where city = 'SQL City' and date = 20180115 and type='murder';
```
Result:
| Date       | Type   | Description                                                           | City      |
|------------|--------|-----------------------------------------------------------------------|-----------|
| 20180115   | Murder | Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". | SQL City  |
