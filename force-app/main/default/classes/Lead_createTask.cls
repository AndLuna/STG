public class Lead_createTask {
    public static void createTask(List<Lead> newLeads) {
        List<Task> tasksToInsert = new List<Task>();

        for (Lead newLead : newLeads) {
            Task newTask = new Task();
            newTask.Subject = 'Follow Up with Lead';
            newTask.WhoId = newLead.Id; 
            newTask.OwnerId = newLead.OwnerId; 
            newTask.Status = 'Not Started';
            newTask.Priority = 'Normal';
            newTask.Description = 'Potencial oportunidade.';
            
            tasksToInsert.add(newTask);
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}
