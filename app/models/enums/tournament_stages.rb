class Enums::TournamentStages
  include Ruby::Enum

  define :qualifications_first_round, "QR1"
  define :qualifications_second_round, "QR2"
  define :qualifications_final_round, "FQR"
  define :rest_of_128, "R128"
  define :rest_of_64, "R64"
  define :rest_of_32, "R32"
  define :rest_of_16, "R16"
  define :quarterfinal, "QF"
  define :semifinal, "SF"
  define :final, "F"
  define :round_robin, "RR"
end
