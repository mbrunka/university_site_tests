# Provided in Jenkins Windows Agent in file C:/Jenkins/secret.py
# for local testing uncomment and fill with your cridentials.
#EMAIL = "*******@****.**"
#PASSWD = "*********"

# Global Variables
BROWSER = "Edge"
MAIN_PAGE_URL = "https://www.put.poznan.pl/"
MAIL_URL = "https://elogin.put.poznan.pl/email/#1"
FACULTY_PAGE = "https://www.cat.put.poznan.pl/"
ICT_STUDENT_PAGE = "https://www.cat.put.poznan.pl/dla-studentow/teleinformatyka"

# Current semester, either SUMMER or WINTER
CURRENT_SEMESTER = "WINTER"

WINTER_SEM_SCHEDULE_XPATH = "//html/body/div[1]/div/div/section/div/article/div/div/div[2]/section[3]/div/table[1]/tbody/tr[2]/td[2]/a"
WINTER_SEM = ["1","3","5","7","9"]

SUMMER_SEM_SCHEDULE_XPATH = "//html/body/div[1]/div/div/section/div/article/div/div/div[2]/section[3]/div/table[1]/tbody/tr[2]/td[2]/a"
SUMMER_SEM = ["2","4","6","8"]

# Folder paths, relative to project root
TEST_CONFIG_FOLDER = "./test_config"
TEMP_FOLDER = "./test_config/temp"