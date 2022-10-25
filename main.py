# OOP Project Classes Objects, UML, Inheritance, Refactor, Reports, Encapsulation
from employee import Manager
from employee import Attendant
from employee import Cook
from employee import Mechanic
from reporting import AccountingReport
from reporting import StaffingReport
from reporting import ScheduleReport
from Shift import MorningShift
from Shift import AfternoonShift
from Shift import NightShift

employees = [
    Manager("Vera", "Schmidt", 2000, MorningShift()),
    Attendant("Chuck", "Norris", 1800, MorningShift()),
    Attendant("Samantha", "Carrington", 1800, AfternoonShift()),
    Cook("Roberto", "Jacketti", 2100, MorningShift()),
    Mechanic("Dave", "Dreissig", 2200, MorningShift()),
    Mechanic("Tina", "Rivers", 2300, MorningShift()),
    Mechanic("Ringo", "Rama", 1900, AfternoonShift()),
    Mechanic("Chuck", "Rainey", 1800, NightShift()),
]

reports = [
    AccountingReport(employees),
    StaffingReport(employees),
    ScheduleReport(employees),
]

for r in reports:
    r.print_report()
    print()
