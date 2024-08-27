import datetime
import re



class UnijobsLibrary:
    """Contains UnijobsLibrary and functions."""

    def get_week_number(self, date):
        """Return week number from date."""
        date_object = datetime.datetime.strptime(date, "%Y-%m-%d")
        year = date_object.year
        day_of_last_dec = datetime.datetime(year, 1, 1).strftime("%a")
        print(day_of_last_dec)
        if day_of_last_dec == "Mon":
            week_num = int(date_object.strftime("%W"))
        else:
            week_num = int(date_object.strftime("%W")) + 1
        return week_num

    def search_keys_for_date_using_regex(self, dictionary):
        """Compile regular expression."""
        pattern = r'\d{4}-\d{2}-\d{2}'
        regex = re.compile(pattern)
        # search keys in dictionary
        for key in dictionary.keys():
            if regex.match(key):
                if dictionary[key]["status"] != "APPROVED":
                    return key
        return None
