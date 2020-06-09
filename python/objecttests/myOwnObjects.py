class SoccerPlayer(self, name, position, offense, defense, tactics):
    #Make your own soccer team!
    def __init__(self):
        self.name = name
        self.position = position
        self.offense = offense
        self.defense = defense
        self.tactics = tactics

    def list_mean(self):
        summing = float(sum(self))
        count   = float(len(self))
        if n == []:
            return False
        return float(summing/count)

    def playerDescription(self):
        print("Name: %s") %(self.name)
        print ("Position: %s") %(self.position)
        print ("Offensive Rating: %d") %(self.offense)
        print("Defensive Rating: %d") %(self.defense)
        print("Tactical Rating: %d") %(self.tactics)
        self.totalRating = [self.offense, self.defense, self.tactics]
        print("Overall Rating: %d") %(self.totalRating.list_mean())

stevenGerrard = SoccerPlayer("Steven_Gerrard", "Midfielder", 86, 77, 94)
stevenGerrard.playerDescription()
