int CalorieIntake(int age,int weight, int height, int activity, String gender)
{
  print('cIstart');
  double CI=0;
  if(gender=='male'){
    CI= 10*weight + 6.25*height-5*age+5;
  }
  else
    {
      CI= 10*weight + 6.25*height-5*age -161;
    }
  if(activity==0){
    CI=CI*1.2;
  }
  else if(activity==1){
    CI=CI*1.55;
  }
  else if(activity==2){
    CI=CI*1.725;
  }
  else{
    CI=CI*1.9;
  }
  print(CI.round());
  return CI.round();
}