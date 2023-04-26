namespace 111222333
{
    public class BatchProcessService
    {
        private BatchProcessRepository _batchProcessRepository;

        public BatchProcessService(BatchProcessRepository batchProcessRepository)
        {
            _batchProcessRepository = batchProcessRepository;
        }

        public BatchProcess GetById(int id)
        {
            return _batchProcessRepository.GetById(id);
        }

        public IEnumerable<BatchProcess> GetAll()
        {
            return _batchProcessRepository.GetAll();
        }

        public void Add(BatchProcess batchProcess)
        {
            _batchProcessRepository.Add(batchProcess);
        }

        public void Update(BatchProcess batchProcess)
        {
            _batchProcessRepository.Update(batchProcess);
        }

        public void Delete(int id)
        {
            _batchProcessRepository.Delete(id);
        }
    }
}