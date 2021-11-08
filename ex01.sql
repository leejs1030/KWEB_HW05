SELECT id, c3, c5 FROM crud WHERE c1 = 11 and c2 = 2;
SELECT * FROM crud WHERE c1 > 18 or c2 < 2;
INSERT INTO crud(id, c4, c1, c2, c3, c5) values(DEFAULT, DEFAULT, 7, 4, 'col101', 0);
INSERT INTO crud(id, c1, c2, c3, c4, c5) values(103, 3, 3, 'col103', DEFAULT, 1);
SELECT * FROM crud WHERE id > 100;
UPDATE crud SET c3 = 'col0', c5 = 0 WHERE c1 > 4 and c1 < 9 and c2 = 1;
SELECT * FROM crud WHERE c1 > 4 and c1 < 9 and c2 = 1;
DELETE FROM crud WHERE c5 = 0;
SELECT * FROM crud WHERE c5 = 0;