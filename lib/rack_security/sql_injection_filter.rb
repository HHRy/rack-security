
class SqlInjectionFilter < AttackFilter

  ATTACK_PATTERNS = [
                      /((\%3D)|(=))[^\n]*((\%27)|(\')|(\-\-)|(\%3B)|(;))/i,
                      /\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/ix,
                      /((\%27)|(\'))union/ix 
                    ]

end
