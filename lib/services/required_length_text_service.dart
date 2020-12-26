class GetTextString{
 
  static getRequiredLengthString({String text,int requiredLength})
  {
      if(text.length < requiredLength)
      {
        return text;
      }
      else{
          return text.substring(0,requiredLength) + '...';
      }
  }
}