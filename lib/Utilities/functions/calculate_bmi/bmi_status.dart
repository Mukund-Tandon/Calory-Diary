String BMIStatus(double _bmi){
  if(_bmi < 18.5)
  {
    return "Your BMI is Less than Normal";
  }
  else if(_bmi >= 18.5 && _bmi <25.0)
  {
    return "BMI Looks good!";
  }
  else if(_bmi >= 25.0 && _bmi<30.0)
  {
    return "Your BMI is slightly more than normal";
  }
  else if(_bmi >=30.0)
  {
    return "Your BMI Doesn't look good!";
  }
  return "error";
}