-- AI pilot aiming control constants.
-- Copyright (C) 2004, Eagle Dynamics.

-- the file is not intended for an end-user editing

-- level4
-- all level4 loaded from wsTypes.lua , before executing this files
-- planes
Default = 0
-- the data
-- planes
------------------------------------------------------------------------------
AIPlanesControl = {}
AIPlanesControl[Default] = {teta  = {500.0, 50.0},
			    gamma = {5.0, 10.0},
			    course_to_gamma = {20.0, 20.0}
			   }

------------------------------------------------------------------------------
Su_27_tbl = {teta  = {1000.0, 100.0},
	     gamma = {5.0, 10.0},
	     course_to_gamma = {100.0, 100.0}
	    }

AIPlanesControl[Su_27] = Su_27_tbl
AIPlanesControl[Su_33] = Su_27_tbl
AIPlanesControl[Su_30] = Su_27_tbl
AIPlanesControl[Su_34] = Su_27_tbl

------------------------------------------------------------------------------
MiG_23_tbl = {teta  = {800.0, 80.0},
	      gamma = {10.0, 15.0},
	      course_to_gamma = {40.0, 10.0}
	     }

AIPlanesControl[MiG_23] = MiG_23_tbl
AIPlanesControl[MiG_27] = MiG_23_tbl

------------------------------------------------------------------------------
AIPlanesControl[F_14] = {teta  = {1000.0, 100.0},
	     		 gamma = {5.0, 10.0},
	     		 course_to_gamma = {100.0, 100.0}
	    		}

------------------------------------------------------------------------------
AIPlanesControl[F_15] = {teta  = {1000.0, 100.0},
			 gamma = {10.0, 20.0},
		   	 course_to_gamma = {200.0, 20.0}
			}

------------------------------------------------------------------------------
F_16_tbl = {teta  = {1000.0, 100.0},
	    gamma = {10.0, 20.0},
	    course_to_gamma = {60.0, 200.0}
	   }

AIPlanesControl[F_16]  = F_16_tbl
AIPlanesControl[F_16A] = F_16_tbl

------------------------------------------------------------------------------
AIPlanesControl[MiG_25] = {teta  = {100.0, 10.0},
		    	   gamma = {5.0, 20.0},
		   	   course_to_gamma = {10.0, 40.0}
			  }

------------------------------------------------------------------------------
AIPlanesControl[Mirage] = {teta  = {1000.0, 100.0},
			   gamma = {5.0, 10.0},
			   course_to_gamma = {100.0, 100.0}
			  }

------------------------------------------------------------------------------
AIPlanesControl[MiG_31] = {teta  = {100.0, 10.0},
		    	   gamma = {5.0, 20.0},
		   	   course_to_gamma = {10.0, 40.0}
			  }

------------------------------------------------------------------------------
AIPlanesControl[F_2] = {teta  = {600.0, 60.0},
			 gamma = {5.0, 10.0},
		   	 course_to_gamma = {30.0, 30.0}
			}
            
AIPlanesControl[TORNADO_IDS] = {teta  = {600.0, 60.0},
			 gamma = {5.0, 10.0},
		   	 course_to_gamma = {30.0, 30.0}
			}

------------------------------------------------------------------------------
Su_24_tbl = {teta  = {800.0, 80.0},
	     gamma = {5.0, 10.0},
	     course_to_gamma = {40.0, 20.0}
	    }

AIPlanesControl[Su_24]   = Su_24_tbl
AIPlanesControl[Su_24MR] = Su_24_tbl

------------------------------------------------------------------------------
FA_18_tbl = {teta  = {1600.0, 160.0},
	     gamma = {10.0, 20.0},
	     course_to_gamma = {100.0, 100.0}
	    }

AIPlanesControl[FA_18]  = FA_18_tbl
AIPlanesControl[FA_18C] = FA_18_tbl

------------------------------------------------------------------------------

Su_25_tbl = {teta  = {400.0, 50.0},
	     gamma = {10.0, 25.0},
	     course_to_gamma = {15.0, 150.0}
	    }

AIPlanesControl[Su_25]  = Su_25_tbl
AIPlanesControl[Su_39]  = Su_25_tbl
AIPlanesControl[Su_25T] = Su_25_tbl

------------------------------------------------------------------------------
AIPlanesControl[A_10A] = {teta  = {400.0, 50.0},
		    	 gamma = {10.0, 25.0},
		   	 course_to_gamma = {15.0, 150.0}
			}

------------------------------------------------------------------------------
AIPlanesControl[A_10C] = {teta  = {400.0, 50.0},
		    	 gamma = {10.0, 25.0},
		   	 course_to_gamma = {15.0, 150.0}
			}

			------------------------------------------------------------------------------
AIPlanesControl[MiG_25P] = {teta  = {100.0, 10.0},
		    	    gamma = {5.0, 20.0},
		   	    course_to_gamma = {10.0, 40.0}
			   }

------------------------------------------------------------------------------
MiG_29_tbl = {teta  = {1000.0, 100.0},
	      gamma = {10.0, 20.0},
   	      course_to_gamma = {100.0, 100.0}
	     }

AIPlanesControl[MiG_29]  = MiG_29_tbl
AIPlanesControl[MiG_29G] = MiG_29_tbl
AIPlanesControl[MiG_29C] = MiG_29_tbl

------------------------------------------------------------------------------
AIPlanesControl[F_4E] = {teta  = {1000.0, 60.0},
			 gamma = {10.0, 10.0},
		   	 course_to_gamma = {30.0, 10.0}
			}

------------------------------------------------------------------------------
AIPlanesControl[F_5E] = {teta  = {600.0, 60.0},
			 gamma = {5.0, 10.0},
		   	 course_to_gamma = {30.0, 80.0}
			}

------------------------------------------------------------------------------
AIPlanesControl[SU_17M4] = {teta  = {800.0, 80.0},
			    gamma = {5.0, 10.0},
		   	    course_to_gamma = {50.0, 80.0}
			   }
